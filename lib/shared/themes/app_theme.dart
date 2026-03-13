import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF1E5AA8));

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
