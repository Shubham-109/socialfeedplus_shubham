import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.textPrimary,
    colorScheme: const ColorScheme.dark(surface: AppColors.background, primary: AppColors.textPrimary, secondary: AppColors.textSecondary),
    textTheme: TextTheme(bodyMedium: AppTextStyles.body, bodySmall: AppTextStyles.subtitle, titleMedium: AppTextStyles.title),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0, titleTextStyle: AppTextStyles.title),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.searchBar,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      hintStyle: AppTextStyles.subtitle,
    ),
  );
}
