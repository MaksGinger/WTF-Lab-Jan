import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        secondary: AppColors.sandPurple,
        onSecondary: AppColors.black,
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.bluePurple,
        foregroundColor: Colors.white,
      ),
      dialogBackgroundColor: AppColors.blue200,
      primaryColor: AppColors.bluePurple,
      scaffoldBackgroundColor: AppColors.grey50,
      cardColor: AppColors.lightBlue,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.darkBluePurple,
        unselectedItemColor: AppColors.darkSandPurple,
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.sandPurple,
        foregroundColor: AppColors.black,
        splashColor: AppColors.darkSandPurple,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      canvasColor: AppColors.grey800,
      colorScheme: const ColorScheme.dark(
        secondary: AppColors.darkSandPurple,
        onSecondary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.grey800,
        foregroundColor: Colors.white,
      ),
      primaryColor: AppColors.bluePurple,
      dialogBackgroundColor: AppColors.grey800,
      scaffoldBackgroundColor: AppColors.darkGrey,
      cardColor: AppColors.grey600,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.sandPurple,
        unselectedItemColor: AppColors.grey500,
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.bluePurple,
        foregroundColor: Colors.white,
        splashColor: AppColors.sandPurple,
      ),
    );
  }
}
