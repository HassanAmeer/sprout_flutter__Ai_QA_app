import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../global/decortions.dart';

ThemeData apptheme() {
  return ThemeData(
    hintColor: Colors.grey,
    brightness: Brightness.light,
    focusColor: AppColors.accent,
    fontFamily: AppStrings.font,
    primaryColor: AppColors.primary,
    dividerColor: AppColors.accent,
    visualDensity: VisualDensity.comfortable,
    scaffoldBackgroundColor: AppColors.background,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.text),
    appBarTheme: const AppBarTheme(
      elevation: 5.0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 14,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontFamily: AppStrings.font,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontSize: 17,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 16.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 15.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 14.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 14.5,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14.5,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w500,
      ),
    ),
    primaryTextTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 14,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontFamily: AppStrings.font,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontSize: 17,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 16.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 15.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 14.5,
        fontFamily: AppStrings.font,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 14.5,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14.5,
        color: AppColors.text,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w500,
      ),
    ),
    cardTheme: CardTheme(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppDecorations.buildMaterialColor(AppColors.primary),
      brightness: Brightness.light,
      errorColor: AppColors.error,
      backgroundColor: AppColors.background,
    ).copyWith(secondary: AppColors.secondary),
  );
}
