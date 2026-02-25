import 'package:flutter/material.dart';

class AppColors {
  // --- EXPANDED DYSLEXIA-FRIENDLY BACKGROUNDS ---
  static const Color bgCream = Color(0xFFFDFBF7);
  static const Color bgSoftBlue = Color(0xFFF0F8FF);
  static const Color bgMint = Color(0xFFF0FAF4);
  static const Color bgPeach = Color(0xFFFFF0E6);      // Warm, reduces visual stress
  static const Color bgSoftYellow = Color(0xFFFEF9C3); // High contrast, low glare
  static const Color bgSoftGray = Color(0xFFF1F5F9);   // Neutral, calm
  static const Color bgSoftPink = Color(0xFFFCE8E8);   // Recommended for some Irlen readers

  static const Color background = bgCream; // Default
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF0EA5E9);
  static const Color highlightYellow = Color(0xFFFDE047);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color textMain = Color(0xFF334155);
  static const Color textMuted = Color(0xFF64748B);

  // Activity Cards
  static const Color cardBlue = Color(0xFFF0F9FF);
  static const Color cardBlueAccent = Color(0xFF3B82F6);
  static const Color cardGreen = Color(0xFFF0FDF4);
  static const Color cardGreenAccent = Color(0xFF22C55E);
  static const Color cardOrange = Color(0xFFFFF7ED);
  static const Color cardOrangeAccent = Color(0xFFF97316);
}

class AppStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
  );

  static const TextStyle dyslexiaText = TextStyle(
    fontSize: 20,
    height: 1.8,
    letterSpacing: 1.2,
    wordSpacing: 2.0,
    color: AppColors.textMain,
  );
}