import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/settings_service.dart';

// Service provider
final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

// State for theme mode
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  final settingsService = ref.watch(settingsServiceProvider);
  return ThemeModeNotifier(settingsService);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._settingsService) : super(ThemeMode.system) {
    _loadThemeMode();
  }

  final SettingsService _settingsService;

  Future<void> _loadThemeMode() async {
    final themeMode = await _settingsService.themeMode();
    state = themeMode;
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == state) return;
    state = newThemeMode;
    await _settingsService.updateThemeMode(newThemeMode);
  }
}

// State for font family
final fontFamilyProvider = StateNotifierProvider<FontFamilyNotifier, String>((
  ref,
) {
  final settingsService = ref.watch(settingsServiceProvider);
  return FontFamilyNotifier(settingsService);
});

class FontFamilyNotifier extends StateNotifier<String> {
  FontFamilyNotifier(this._settingsService) : super('SKCuriosity') {
    _loadFontFamily();
  }

  final SettingsService _settingsService;

  Future<void> _loadFontFamily() async {
    final fontFamily = await _settingsService.fontFamily();
    state = fontFamily;
  }

  Future<void> updateFontFamily(String newFontFamily) async {
    if (newFontFamily == state) return;
    state = newFontFamily;
    await _settingsService.updateFontFamily(newFontFamily);
  }
}

// For compatibility with old code, this can be removed later
final settingsProvider = Provider<SettingsProviderCompat>((ref) {
  return SettingsProviderCompat(ref);
});

// Compatibility layer to transition from ChangeNotifier pattern
class SettingsProviderCompat {
  SettingsProviderCompat(this._ref);
  final Ref _ref;

  ThemeMode get themeMode => _ref.read(themeModeProvider);
  String get fontFamily => _ref.read(fontFamilyProvider);

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    await _ref.read(themeModeProvider.notifier).updateThemeMode(newThemeMode);
  }

  Future<void> updateFontFamily(String newFontFamily) async {
    await _ref
        .read(fontFamilyProvider.notifier)
        .updateFontFamily(newFontFamily);
  }
}
