import 'package:flutter/material.dart';
import 'package:test_code/constant.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color.fromARGB(77, 255, 255, 255),
    secondary: Color.fromARGB(77, 255, 255, 255),
    surface: Color(0xFFEBEDFA),
    onPrimary: Color.fromRGBO(12, 100, 255, 1),
    onSecondary: Color.fromRGBO(60, 191, 65, 1),
    onError: Color.fromRGBO(246, 9, 67, 1),
    onInverseSurface: Color.fromRGBO(201, 241, 203, 1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color.fromRGBO(58, 58, 58, 0.481),
    secondary: const Color.fromARGB(255, 54, 54, 54),
    surface: const Color.fromARGB(255, 0, 0, 0),
    onPrimary: const Color.fromRGBO(20, 111, 255, 1),
    onSecondary: const Color.fromRGBO(61, 203, 63, 1),
    onError: const Color.fromRGBO(246, 24, 77, 1),
    onInverseSurface: Color.fromRGBO(0, 96, 2, 1),
  ),
);

Map<String, Color> statusColors = {
  "Recived": Colors.green.shade400,
  "Authorized": Colors.blue.shade400,
  "Rejected": Colors.red.shade400,
};

Map<String, String> dbPaths = {
  "Recived": "db/recived_data",
  "Authorized": "db/authorized_data",
  "Rejected": "db/rejected_data",
};
