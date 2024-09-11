import 'package:firebase_todo_app/utils/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ShadColorScheme _lightColorScheme = colorScheme[0].light;
  ShadColorScheme _darkColorScheme = colorScheme[0].dark;
  int _selectedColorScheme = 0;

  ThemeMode get themeMode => _themeMode;
  ShadColorScheme get lightColorScheme => _lightColorScheme;
  ShadColorScheme get darkColorScheme => _darkColorScheme;
  int get selectedColorScheme => _selectedColorScheme;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeColorScheme(int index) {
    _selectedColorScheme = index;
    _lightColorScheme = colorScheme[index].light;
    _darkColorScheme = colorScheme[index].dark;
    notifyListeners();
  }
}
