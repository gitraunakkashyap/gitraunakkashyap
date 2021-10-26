import 'package:flutter/material.dart';

class MyTheme{
  static const MaterialColor appColor = MaterialColor(_appColorPrimaryValue, <int, Color>{
    50: Color(0xFFE6EDE8),
    100: Color(0xFFC0D1C7),
    200: Color(0xFF97B3A1),
    300: Color(0xFF6D957B),
    400: Color(0xFF4D7E5F),
    500: Color(_appColorPrimaryValue),
    600: Color(0xFF295F3D),
    700: Color(0xFF235434),
    800: Color(0xFF1D4A2C),
    900: Color(0xFF12391E),
  });
  static const int _appColorPrimaryValue = 0xFF2E6743;

  static const MaterialColor appColorAccent = MaterialColor(_appColorAccentValue, <int, Color>{
    100: Color(0xFF76FF9B),
    200: Color(_appColorAccentValue),
    400: Color(0xFF10FF51),
    700: Color(0xFF00F643),
  });
  static const int _appColorAccentValue = 0xFF43FF76;
}