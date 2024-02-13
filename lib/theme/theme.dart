// ignore_for_file: file_names
import 'package:flutter/material.dart';

// Color.fromRGBO(21, 170, 87, 1.0)

class MyaiColors {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      // fontFamily: 'IndieFlower',
      primarySwatch: const MaterialColor(0xFF15AA56, <int, Color>{
        50: Color(0xFFF4FBF7),
        100: Color(0xFFE8F7EF),
        200: Color(0xFFC5EAD5),
        300: Color(0xFFA0DDBA),
        400: Color(0xFF5CC489),
        500: Color(0xFF15AA56),
        600: Color(0xFF13984D),
        700: Color(0xFF0D6634),
        800: Color(0xFF0A4D27),
        900: Color(0xFF073219),
      }));
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'IndieFlower',
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      primarySwatch: const MaterialColor(0xFF6A7FC1, <int, Color>{
        50: Color(0xFFF8F9FC),
        100: Color(0xFFF1F3F9),
        200: Color(0xFFDADFF0),
        300: Color(0xFFC2CBE6),
        400: Color(0xFF97A6D4),
        500: Color(0xFF6A7FC1),
        600: Color(0xFF5F72AC),
        700: Color(0xFF404D74),
        800: Color(0xFF303A57),
        900: Color(0xFF1F2538),
      }));
}
