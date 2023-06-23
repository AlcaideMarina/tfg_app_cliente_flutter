import 'package:flutter/material.dart';

import 'custom_colors.dart';

class AppTheme {
  static const Color primary = CustomColors.redPrimaryColor;

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: CustomColors.redPrimaryColor,
          iconTheme: IconThemeData(color: CustomColors.whiteColor)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primary))));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0,
          iconTheme: IconThemeData(color: CustomColors.redPrimaryColor)),
      scaffoldBackgroundColor: CustomColors.blackColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primary))));
}
