import 'package:brivlo/theme/dark_mode.dart';
import 'package:brivlo/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme is light mode
  ThemeData _themeData = lightMode;

  // Getter for the current theme
  ThemeData get themeData => _themeData;

  // is current theme in dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
