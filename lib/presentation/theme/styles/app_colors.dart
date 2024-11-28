import 'package:flutter/material.dart';

@immutable
class AppColors {
  // Text Colors
  final Color lightTextPrimary = const Color(0xFFFFFAFA);
  final Color darkTextPrimary = const Color(0xFF0C0F14);
  final Color lightTextSecondary = const Color(0xFFB0B0B0);
  final Color darkTextSecondary = const Color(0xFF707070);

  // Theme Colors
  final Color primary = Colors.amber;
  final Color primaryContainer = const Color(0xFF94BA45);
  final Color secondary = const Color(0xFF4CAF50);
  final Color secondaryContainer = const Color(0xFF388E3C);

  // Background Colors
  final Color dark = const Color(0xFF171717);
  final Color darkSecondary = const Color(0xFF1D1E20);
  final Color light = const Color(0xFFF5F4F0);
  final Color lightSecondary = const Color(0xFFFFFFFF);

  // Status Colors
  final Color success = const Color(0xFF4CAF50);
  final Color warning = const Color(0xFFFFC107);
  final Color error = const Color(0xFFF44336);

  Color shift(Color c, double d) => _shiftHsl(c, d);

  Color _shiftHsl(Color c, double d) {
    final hslColor = HSLColor.fromColor(c);
    return hslColor
        .withLightness((hslColor.lightness + d).clamp(0.0, 1.0))
        .toColor();
  }
}
