import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool isDarkMode = false;
  static AppSettings instance = AppSettings();

  changeDarkMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}
