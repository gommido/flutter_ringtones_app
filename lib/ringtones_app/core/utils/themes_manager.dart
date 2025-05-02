
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

ThemeData appTheme(){
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.black,
    appBarTheme:  const AppBarTheme(
      backgroundColor: ColorManager.black,
    ),
    textTheme: const TextTheme(
      bodySmall:  TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s10,
        fontFamily: AppConstants.fontFamily,
      ),
      bodyMedium:  TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s12,
        fontFamily: AppConstants.fontFamily,
      ),
      bodyLarge: TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s14,
        fontFamily: AppConstants.fontFamily,
      ),
    ),
    sliderTheme: const SliderThemeData(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.0),
        trackHeight: 0.5
    ),
  );
}