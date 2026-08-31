// lib/features/profile/presentation/profile_screen.dart
//
// Section 1 placeholder — replaced by settings (language toggle, PDF export)
// in a later section.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('nav.profile'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(AppI18n.t('nav.profile'), style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}