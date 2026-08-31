// lib/features/reminders/presentation/reminders_screen.dart
//
// Section 1 placeholder — replaced by the weekly schedule UI in Section 7.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('reminders.title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_active, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(AppI18n.t('reminders.title'), style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}