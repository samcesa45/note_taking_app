import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/services/local_storage_service.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
      return ThemeController(ref.read(localStorageProvider));
    });

class ThemeController extends StateNotifier<ThemeMode> {
  final SharedPreferencesLocalStorageService _storageService;
  ThemeController(this._storageService) : super(ThemeMode.system) {
    _loadThemeMode();
  }
  Future<void> _loadThemeMode() async {
    final index = await _storageService.getThemeModeIndex();

    switch (index) {
      case 1:
        state = ThemeMode.light;
        break;
      case 2:
        state = ThemeMode.dark;
        break;
      default:
        state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _storageService.setThemeModeIndex(mode.index);
  }

  Future<void> reset() async {
    await setThemeMode(ThemeMode.system);
  }
}
