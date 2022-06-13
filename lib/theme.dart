import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = "theme_key";

  setTheme(ThemeMode value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_KEY, value.index);
  }

  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var theme = prefs.getInt(PREF_KEY);
    return theme == null
        ? ThemeMode.system
        : ThemeMode.values[theme];
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final ThemePreferences _preferences = ThemePreferences();
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    getPreferences();
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _preferences.setTheme(themeMode);
    notifyListeners();
  }

  void getPreferences() async {
    _themeMode = await _preferences.getTheme();
  }
}

var appTheme = ThemeData(
  brightness: Brightness.light,
);
var appDarkTheme = ThemeData(
  brightness: Brightness.dark,
);
