import 'package:firebase_todo_app/utils/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ShadColorScheme _lightColorScheme = colorScheme[0].light;
  ShadColorScheme _darkColorScheme = colorScheme[0].dark;
  int _selectedColorScheme = 0;

  // Load saved color scheme on initialization
  ThemeProvider() {
    _loadSelectedColorScheme();
  }

  ThemeMode get themeMode => _themeMode;
  ShadColorScheme get lightColorScheme => _lightColorScheme;
  ShadColorScheme get darkColorScheme => _darkColorScheme;
  int get selectedColorScheme => _selectedColorScheme;

  // Toggle between light and dark theme
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Change color scheme and save it to SharedPreferences
  void changeColorScheme(int index) async {
    _selectedColorScheme = index;
    _lightColorScheme = colorScheme[index].light;
    _darkColorScheme = colorScheme[index].dark;
    notifyListeners();
    await _saveSelectedColorScheme(index); // Save the selected color scheme
  }

  // Save selected color scheme to SharedPreferences
  Future<void> _saveSelectedColorScheme(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColorScheme', index);
  }

  // Load selected color scheme from SharedPreferences
  Future<void> _loadSelectedColorScheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedIndex = prefs.getInt('selectedColorScheme');
    if (savedIndex != null &&
        savedIndex >= 0 &&
        savedIndex < colorScheme.length) {
      changeColorScheme(savedIndex);
    }
  }
}
