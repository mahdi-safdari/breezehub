import 'package:breezehub/core/utils/constants.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final ThemeData myTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'sfpro',
    brightness: Brightness.dark,
    dividerTheme: DividerThemeData(color: Constants.quaternary, space: 10),
    textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: 86, fontWeight: FontWeight.w100, color: Constants.primary),
      displaySmall: const TextStyle(color: Constants.primary),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constants.secondary),
      titleMedium: TextStyle(color: Constants.secondary, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(color: Constants.secondary, fontWeight: FontWeight.bold, letterSpacing: -0.50),
      labelLarge: const TextStyle(fontWeight: FontWeight.bold, color: Constants.primary),
      labelSmall: const TextStyle(color: Constants.percentRainColor, fontWeight: FontWeight.w600),
      headlineSmall: const TextStyle(color: Constants.primary, fontWeight: FontWeight.w600),
      bodyLarge: const TextStyle(color: Constants.primary, height: 1.1),
    ),
  );
}
