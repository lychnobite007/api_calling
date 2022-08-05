import 'package:api_calling/dark_light_mode/theme_preferences.dart';
import 'package:flutter/cupertino.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences themePreferences = ThemePreferences();
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    themePreferences = ThemePreferences();
    getPreferences();

  }

  getPreferences() async {
    // ignore: unnecessary_statements
    _isDark == await themePreferences.getTheme();
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    themePreferences.setTheme(value);
    notifyListeners();
  }

}