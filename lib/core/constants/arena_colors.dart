import 'package:flutter/material.dart';

class ArenaColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF030213);
  static const Color mutedBackground = Color(0xFFECECF0);
  static const Color mutedText = Color(0xFF717182);
  static const Color accentBackground = Color(0xFFE9EBEF);
  static const Color inputBackground = Color(0xFFF3F3F5);
  static const Color destructive = Color(0xFFD4183D);
  
  static Color get border => foreground.withValues(alpha: 0.1);
}
