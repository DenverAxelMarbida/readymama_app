// lib/features/hospital_bag/presentation/hospital_bag_screen.dart
//
// Section 1 placeholder — replaced by the full checklist in Section 5.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class HospitalBagScreen extends StatelessWidget {
  const HospitalBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('hospital_bag.title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.luggage, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(AppI18n.t('hospital_bag.title'), style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}