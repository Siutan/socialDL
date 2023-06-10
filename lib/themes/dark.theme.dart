import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkTheme {
  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFFE5383B),
    hintColor: const Color(0xFF292F39),
    scaffoldBackgroundColor: const Color(0xFF161A1D),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFE5383B),
      iconTheme: IconThemeData(
        color: Colors.white,
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
      buttonColor: const Color(0xFF161A1D),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}