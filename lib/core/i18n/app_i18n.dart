// lib/core/i18n/app_i18n.dart
//
// Minimal i18n bridge required by the Phase 2 shell (bottom navigation
// labels, screen titles). Loads en.json / fil.json once at startup and
// exposes dot-path lookups with {placeholder} interpolation.
//
// NOTE: Section 2 formalizes this into the Riverpod locale service with
// runtime toggling (no app restart) and persisted selection. This static
// helper is the deliberately small dependency the shell needs today.

import 'dart:convert';
import 'dart:ui' show Locale;

import 'package:flutter/services.dart' show rootBundle;

abstract final class AppI18n {
  static const Locale en = Locale('en');
  static const Locale fil = Locale('fil');

  static const List<Locale> supportedLocales = [en, fil];

  static Map<String, dynamic> _en = const {};
  static Map<String, dynamic> _fil = const {};
  static Locale _current = en;

  static Locale get currentLocale => _current;

  static void setLocale(Locale locale) => _current = locale;

  static Future<void> load() async {
    _en = jsonDecode(await rootBundle.loadString('assets/i18n/en.json')) as Map<String, dynamic>;
    _fil = jsonDecode(await rootBundle.loadString('assets/i18n/fil.json')) as Map<String, dynamic>;
  }

  static Map<String, dynamic> get _strings =>
      _current.languageCode == fil.languageCode ? _fil : _en;

  /// Dot-path lookup with optional {placeholder} interpolation, e.g.
  /// `AppI18n.t('dashboard.score_label', {'score': '52', 'max': '80', 'statusLabel': 'Needs Preparation'})`.
  static String t(String key, [Map<String, String> params = const {}]) {
    var text = _lookup(_strings, key) ?? _lookup(_en, key) ?? key;
    for (final entry in params.entries) {
      text = text.replaceAll('{${entry.key}}', entry.value);
    }
    return text;
  }

  static String? _lookup(Map<String, dynamic> map, String key) {
    Map<String, dynamic>? current = map;
    for (final part in key.split('.')) {
      final value = current?[part];
      if (value is String) {
        return value;
      }
      if (value is Map<String, dynamic>) {
        current = value;
      } else {
        return null;
      }
    }
    return null;
  }
}