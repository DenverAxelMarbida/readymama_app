// lib/features/dashboard/presentation/dashboard_screen.dart
//
// Section 1 placeholder — replaced by the full dashboard feature in Section 3.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('nav.dashboard'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.space_dashboard, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(AppI18n.t('nav.dashboard'), style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              AppI18n.t('tagline'),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}