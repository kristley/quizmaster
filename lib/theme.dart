import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  static const _prefKey = "theme_key";
  SharedPreferences _prefs;
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeChangeNotifier(this._prefs) {
    getPreferences();
    notifyListeners();
  }

  getTheme() {
    var theme = _prefs.getInt(_prefKey);
    return theme == null
        ? ThemeMode.system
        : ThemeMode.values[theme];
  }

  setTheme(ThemeMode value) {
    _prefs.setInt(_prefKey, value.index);
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    setTheme(themeMode);
    notifyListeners();
  }

  void getPreferences() {
    _themeMode = getTheme();
  }
}

var appTheme = ThemeData(
  brightness: Brightness.light,
);
var appDarkTheme = ThemeData(
  brightness: Brightness.dark,
);
