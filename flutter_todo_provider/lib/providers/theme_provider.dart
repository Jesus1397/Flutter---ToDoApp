import 'package:flutter/material.dart';

class ThemeChangeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.dark();

  ThemeData get getTheme => _themeData;

  set setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
