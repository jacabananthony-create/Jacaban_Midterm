import 'package:flutter/material.dart';

class AppTheme {
  static const Color seed = Color(0xFF3F51B5); // indigo
  static const Color accent = Color(0xFF26A69A); // teal

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      secondary: accent,
      brightness: brightness,
    );
    final isLight = brightness == Brightness.light;

    final base = ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      useMaterial3: true,
    );

    final textTheme = base.textTheme
        .copyWith(
          headlineLarge: const TextStyle(
              fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          headlineMedium:
              const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          titleLarge:
              const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          titleMedium:
              const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.45),
          bodyMedium: const TextStyle(fontSize: 14, height: 1.4),
          labelLarge: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    return base.copyWith(
      textTheme: textTheme,
      scaffoldBackgroundColor:
          isLight ? const Color(0xFFF4F5FB) : const Color(0xFF12131A),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: scheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: isLight ? 2 : 0,
        color: isLight ? Colors.white : const Color(0xFF1D1F2B),
        shadowColor: scheme.primary.withAlpha(60),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: scheme.outlineVariant.withAlpha(isLight ? 60 : 120)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(200, 54),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: textTheme.labelLarge,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(200, 54),
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: scheme.primary, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.secondary,
        linearTrackColor: scheme.primary.withAlpha(30),
        linearMinHeight: 8,
      ),
    );
  }
}