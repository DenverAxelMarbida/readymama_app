// lib/core/theme/app_colors.dart
//
// ReadyMAMA central color palette.
// Feature widgets MUST reference these constants — never inline raw
// Color(0xFF...) values. High-contrast neutrals and status tiers are
// tuned for low-literacy accessibility (strong figure/ground separation).

import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color readyMamaPink = Color(0xFFE91E63);
  static const Color pinkDark = Color(0xFFC2185B);
  static const Color pinkLight = Color(0xFFF8BBD0);
  static const Color pinkContainer = Color(0xFFFCE4EC);

  // Neutrals
  static const Color ink = Color(0xFF212121);
  static const Color inkSoft = Color(0xFF616161);
  static const Color canvas = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);

  // Semantic / status tiers
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color danger = Color(0xFFC62828);
  static const Color info = Color(0xFF1565C0);
}