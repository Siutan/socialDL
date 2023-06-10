import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFE5383B),
    hintColor: const Color(0xFFBA181B),
    scaffoldBackgroundColor: const Color(0xFFF4F4F4),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFBA181B),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      button: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFFE5383B),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
