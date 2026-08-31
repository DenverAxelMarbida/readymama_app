import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:readymama_app/app/app.dart';
import 'package:readymama_app/core/i18n/app_i18n.dart';

void main() {
  testWidgets('App shell renders dashboard and all bottom nav tabs',
      (WidgetTester tester) async {
    await AppI18n.load();
    await tester.pumpWidget(const ProviderScope(child: ReadyMamaApp()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    for (final label in ['Dashboard', 'Assessment', 'Hospital Bag', 'Emergency', 'Profile']) {
      expect(find.text(label), findsWidgets);
    }
  });
}