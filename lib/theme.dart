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
    onPrimaryContainer: Color.fromRGBO(198, 240, 205, 1),
    onSecondaryContainer: Color.fromRGBO(187, 226, 254, 100),
    onSurface: Color.fromRGBO(21, 21, 21, 1),

    onPrimaryFixed: Color.fromRGBO(20, 120, 10, 100),
    onPrimaryFixedVariant: Color.fromRGBO(27, 173, 13, 100),

    onSecondaryFixed: Color.fromRGBO(46, 101, 164, 100),
    onSecondaryFixedVariant: Color.fromRGBO(98, 133, 249, 100),

    onSurfaceVariant: Color.fromRGBO(164, 46, 152, 100),
    onTertiary: Color.fromRGBO(2, 2, 2, 1),

    outline: Colors.black,
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
    onPrimaryContainer: Color.fromRGBO(159, 238, 174, 1),
    onSecondaryContainer: Color.fromRGBO(85, 161, 176, 0.8),
    onSurface: Color.fromRGBO(25, 25, 25, 1),

    onPrimaryFixed: Color.fromRGBO(20, 120, 10, 100),
    onPrimaryFixedVariant: Color.fromRGBO(27, 173, 13, 100),

    onSecondaryFixed: Color.fromRGBO(46, 101, 164, 100),
    onSecondaryFixedVariant: Color.fromRGBO(98, 133, 249, 100),

    onSurfaceVariant: Color.fromRGBO(0, 0, 0, 1),
    onTertiary: Color.fromRGBO(50, 50, 50, 1),

    outline: Colors.white,
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
