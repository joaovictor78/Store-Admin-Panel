import 'color_palettes.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    backgroundColor: ColorPalettes.lightBG,
    primaryColor: ColorPalettes.lightPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorPalettes.accentPrimary,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.lightPrimary,
    ),
    scaffoldBackgroundColor: ColorPalettes.lightBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextStyle(
        color: ColorPalettes.darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
