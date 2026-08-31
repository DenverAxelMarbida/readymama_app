// lib/features/emergency/presentation/emergency_screen.dart
//
// Section 1 placeholder — replaced by quick-action contact buttons in Section 6.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('emergency.title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emergency, size: 56, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(AppI18n.t('emergency.title'), style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}