// lib/app/app.dart
//
// Root widget: MaterialApp.router wired to the GoRouter shell, ReadyMAMA
// theme, and en/fil Material localizations.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';
import 'package:readymama_app/core/router/app_router.dart';
import 'package:readymama_app/core/theme/app_theme.dart';

class ReadyMamaApp extends StatelessWidget {
  const ReadyMamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppI18n.t('app_name'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: appRouter,
      locale: AppI18n.currentLocale,
      supportedLocales: AppI18n.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}