// lib/main.dart
//
// ReadyMAMA entry point. Loads i18n strings from assets before the first
// frame, then boots the app inside a Riverpod ProviderScope.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:readymama_app/app/app.dart';
import 'package:readymama_app/core/i18n/app_i18n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppI18n.load();
  runApp(const ProviderScope(child: ReadyMamaApp()));
}