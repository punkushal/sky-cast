import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color lightBlue = Color(0xFFB3D9F2);
  static const Color veryLightBlue = Color(0xFFE3F2FD);
  static const Color darkBlue = Color(0xFF2C3E50);
  static const Color accentGreen = Color(0xFF00C853);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color backgroundColor = Color(0xFFF5F5F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color searchBackground = Color(0xFFEEEFF3);

  // Gradient colors for splash screen
  static const Color gradientStart = Color(0xFFB3D9F2);
  static const Color gradientEnd = Color(0xFF9B7FD9);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: .light,

    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      secondary: lightBlue,
      surface: cardBackground,
      error: Colors.red,
      onPrimary: backgroundColor,
      onSecondary: textPrimary,
      onSurface: textPrimary,
    ),

    // scaffold background
    scaffoldBackgroundColor: backgroundColor,

    // App Bar Theme
    appBarTheme: AppBarThemeData(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: textPrimary, size: 24),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
    ),

    // card theme
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    // input decoration theme
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: cardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryBlue, width: 1),
      ),
      hintStyle: TextStyle(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      prefixIconColor: primaryBlue,
    ),

    // List title theme
    listTileTheme: ListTileThemeData(
      tileColor: cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      iconColor: primaryBlue,
      textColor: textPrimary,
    ),

    // text theme
    textTheme: TextTheme(
      // Display - large temperature
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1,
      ),

      displayMedium: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1,
      ),

      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      // Headline - section titles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      // title - app bar, card titles
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),

      titleMedium: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      // body - regular text
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
        fontWeight: FontWeight.w400,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: textPrimary,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textPrimary,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  // Custom gradients
  static const LinearGradient splashGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: AlignmentGeometry.topCenter,
    end: AlignmentGeometry.bottomCenter,
  );

  // Custom shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: textPrimary.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
  ];
}
