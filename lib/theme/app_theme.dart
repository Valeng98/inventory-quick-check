import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF0A0A0B);
  static const Color bg2 = Color(0xFF111113);
  static const Color bg3 = Color(0xFF18181C);
  static const Color border = Color(0x14FFFFFF);
  static const Color text = Color(0xFFF0EEE8);
  static const Color muted = Color(0xFF888780);
  static const Color accent = Color(0xFF5DCAA5);
  static const Color accentDark = Color(0xFF1D9E75);
  static const Color amber = Color(0xFFEF9F27);
  static const Color red = Color(0xFFE24B4A);
  static const Color blue = Color(0xFF85B7EB);

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: blue,
          surface: bg2,
          error: red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: text, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.3,
          ),
          iconTheme: IconThemeData(color: text),
        ),
        cardTheme: CardThemeData(
          color: bg2,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: border, width: 0.5),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: text, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5),
          headlineMedium: TextStyle(color: text, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.3),
          titleLarge: TextStyle(color: text, fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: text, fontSize: 15, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: text, fontSize: 15),
          bodyMedium: TextStyle(color: muted, fontSize: 13),
          labelSmall: TextStyle(color: muted, fontSize: 11, letterSpacing: 0.5),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: bg3,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: accent, width: 1),
          ),
          hintStyle: const TextStyle(color: muted, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        dividerColor: border,
      );
}
