import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box _settingsBox;

  ThemeCubit(this._settingsBox) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeIndex = _settingsBox.get('themeMode', defaultValue: 0);
    emit(ThemeMode.values[themeIndex]);
  }

  void toggleTheme(bool isDark) {
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _settingsBox.put('themeMode', newMode.index);
    emit(newMode);
  }

  void setThemeMode(ThemeMode mode) {
    _settingsBox.put('themeMode', mode.index);
    emit(mode);
  }
}
