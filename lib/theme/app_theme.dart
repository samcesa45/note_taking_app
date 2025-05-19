import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/colors.dart';

class AppTheme {
  static const Color primaryColor = AppColors.appBlue1;
  static const Color secondaryColor = AppColors.appBlue2;
  static const Color accentColor = AppColors.appBlue2;
  static const Color textColor = Colors.black87;
  static const Color hintTextColor = Colors.grey;
  static const Color cardColor = AppColors.appPink1;
  static const Color backgroundColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    // primarySwatch: Colors.black,
    fontFamily: 'Avenir',
    useMaterial3: false,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20.0,
        fontFamily: 'Avenir',
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor),
      ),
      hintStyle: TextStyle(color: hintTextColor),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    colorScheme: const ColorScheme.dark(
      primary: Colors.grey,
      secondary: cardColor,
      tertiary: Colors.tealAccent,
    ),
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      hintStyle: TextStyle(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.grey,
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[600],
      foregroundColor: cardColor,
    ),
  );
}
