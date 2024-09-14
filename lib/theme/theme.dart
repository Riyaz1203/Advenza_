import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Color.fromARGB(255, 42, 88, 42);
  static Color secondaryColor = Color(0xFF81B29A);
  static Color backgroundColor = Color(0xFFF7F7F7);
  static Color accentColor = Color(0xFFF4A261);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;

  static TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: blackColor,
  );

  static TextStyle subHeadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: blackColor,
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: 14,
    color: blackColor,
  );
}
