// lib/features/assessment/presentation/assessment_results_screen.dart
//
// Section 1 placeholder — replaced by the results breakdown in Section 4.

import 'package:flutter/material.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class AssessmentResultsScreen extends StatelessWidget {
  const AssessmentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppI18n.t('assessment.results_title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(AppI18n.t('assessment.results_title'), style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}