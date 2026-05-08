import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.primaryForegroundLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.secondaryForegroundLight,
        surface: AppColors.backgroundLight,
        onSurface: AppColors.foregroundLight,
        error: AppColors.destructiveLight,
        onError: AppColors.destructiveForegroundLight,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.foregroundLight, fontSize: 32, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(color: AppColors.foregroundLight, fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: AppColors.foregroundLight, fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: AppColors.foregroundLight, fontSize: 20, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: AppColors.foregroundLight, fontSize: 18, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: AppColors.foregroundLight, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: AppColors.foregroundLight, fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: AppColors.mutedForegroundLight, fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: AppColors.foregroundLight, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.foregroundLight,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundLight,
        shadowColor: AppColors.borderLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.foregroundLight, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.mutedForegroundLight),
        labelStyle: const TextStyle(color: AppColors.mutedForegroundLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.foregroundLight,
          foregroundColor: AppColors.backgroundLight,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56), // h-14 is 56px
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // rounded-xl
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2, // tracking-wide
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.foregroundLight,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        onPrimary: AppColors.primaryForegroundDark,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.secondaryForegroundDark,
        surface: AppColors.backgroundDark,
        onSurface: AppColors.foregroundDark,
        error: AppColors.destructiveDark,
        onError: AppColors.destructiveForegroundDark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.foregroundDark, fontSize: 32, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(color: AppColors.foregroundDark, fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: AppColors.foregroundDark, fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: AppColors.foregroundDark, fontSize: 20, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: AppColors.foregroundDark, fontSize: 18, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: AppColors.foregroundDark, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: AppColors.foregroundDark, fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: AppColors.mutedForegroundDark, fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: AppColors.foregroundDark, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.foregroundDark,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundDark,
        shadowColor: AppColors.borderDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.foregroundDark, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.mutedForegroundDark),
        labelStyle: const TextStyle(color: AppColors.mutedForegroundDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.foregroundDark,
          foregroundColor: AppColors.backgroundDark,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.foregroundDark,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
