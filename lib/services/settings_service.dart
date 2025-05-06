import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // Keep constants for keys
  static const String _themeKey = 'theme_mode';
  static const String _fontKey = 'font_family';

  // Daftar font yang tersedia
  static List<String> get availableFonts => [
    'SKCuriosity',
    'Dongle',
    'Roboto',
    'OpenSans',
    'Poppins',
    // Tambahkan font lain yang sudah didaftarkan di pubspec.yaml
  ];

  // Load theme dengan handling khusus untuk web
  Future<ThemeMode> themeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(_themeKey);

      // Special handling for web if needed
      if (kIsWeb && value == null) {
        // Default for web if needed
        return ThemeMode.system;
      }

      switch (value) {
        case 'dark':
          return ThemeMode.dark;
        case 'light':
          return ThemeMode.light;
        default:
          return ThemeMode.system;
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
      return ThemeMode.system;
    }
  }

  // Save theme
  Future<void> updateThemeMode(ThemeMode theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      switch (theme) {
        case ThemeMode.dark:
          await prefs.setString(_themeKey, 'dark');
          break;
        case ThemeMode.light:
          await prefs.setString(_themeKey, 'light');
          break;
        case ThemeMode.system:
          await prefs.setString(_themeKey, 'system');
          break;
      }
    } catch (e) {
      debugPrint('Error saving theme: $e');
      // Simply log but don't throw to avoid UI disruption
    }
  }

  // Load font
  Future<String> fontFamily() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_fontKey) ?? availableFonts.first;
    } catch (e) {
      debugPrint('Error loading font: $e');
      return availableFonts.first;
    }
  }

  // Save font
  Future<void> updateFontFamily(String fontFamily) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_fontKey, fontFamily);
    } catch (e) {
      debugPrint('Error saving font: $e');
      // Simply log but don't throw to avoid UI disruption
    }
  }
}
