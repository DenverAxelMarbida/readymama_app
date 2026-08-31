// lib/core/theme/app_theme.dart
//
// Light Material 3 theme tuned for ReadyMAMA: seeded from the brand
// pink, larger base typography, and strong contrast for low-literacy
// accessibility. Feature widgets must reference AppColors, never raw
// Color(0xFF...) literals.

import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.readyMamaPink,
      brightness: Brightness.light,
      primary: AppColors.readyMamaPink,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.pinkContainer,
      onPrimaryContainer: AppColors.pinkDark,
      onSurface: AppColors.ink,
      surface: AppColors.surface,
    );

    final baseTextTheme = Typography.material2021(
      colorScheme: colorScheme,
    ).black;

    final textTheme = baseTextTheme.copyWith(
      displayMedium: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
      headlineMedium: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
      headlineSmall: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
      titleLarge: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: const TextStyle(fontSize: 18, height: 1.4),
      bodyMedium: const TextStyle(fontSize: 16, height: 1.4),
      bodySmall: const TextStyle(fontSize: 14, height: 1.3),
      labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      labelMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.canvas,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.pinkContainer,
        height: 72,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.all(const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        )),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.readyMamaPink);
          }
          return const IconThemeData(color: AppColors.inkSoft);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.readyMamaPink,
          foregroundColor: AppColors.onPrimary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.readyMamaPink,
          side: const BorderSide(color: AppColors.readyMamaPink, width: 1.5),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.outline),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.readyMamaPink,
        linearTrackColor: AppColors.pinkContainer,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outline,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}