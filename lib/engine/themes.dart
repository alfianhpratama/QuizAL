import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    primarySwatch: primary,
    primaryColor: primary,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: darkBlue.shade400,
      ),
      backgroundColor: darkBlue,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 15.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primaryAccent,
    ),
    scaffoldBackgroundColor: darkBlue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(primary),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        ),
        foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: primary,
      color: Colors.amber,
    ),
    // cardColor: darkBlue.shade400,
    cardTheme: CardTheme(
      color: darkBlue.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
    ),
  );

  static const MaterialColor darkBlue =
      MaterialColor(_darkBluePrimaryValue, <int, Color>{
    50: Color(0xFFE1E4E8),
    100: Color(0xFFB4BDC5),
    200: Color(0xFF82919E),
    300: Color(0xFF4F6477),
    400: Color(0xFF2A4359),
    500: Color(_darkBluePrimaryValue),
    600: Color(0xFF031E36),
    700: Color(0xFF03192E),
    800: Color(0xFF021427),
    900: Color(0xFF010C1A),
  });
  static const int _darkBluePrimaryValue = 0xFF04223C;

  static const MaterialColor darkBlueAccent =
      MaterialColor(_darkBlueAccentValue, <int, Color>{
    100: Color(0xFF5888FF),
    200: Color(_darkBlueAccentValue),
    400: Color(0xFF0045F1),
    700: Color(0xFF003ED8),
  });
  static const int _darkBlueAccentValue = 0xFF2564FF;

  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE3EEF4),
    100: Color(0xFFB9D5E3),
    200: Color(0xFF8BB9D0),
    300: Color(0xFF5C9DBD),
    400: Color(0xFF3988AF),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF136B99),
    700: Color(0xFF10608F),
    800: Color(0xFF0C5685),
    900: Color(0xFF064374),
  });
  static const int _primaryPrimaryValue = 0xFF1673A1;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFA3D1FF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF3D9EFF),
    700: Color(0xFF2491FF),
  });
  static const int _primaryAccentValue = 0xFF70B8FF;
}
