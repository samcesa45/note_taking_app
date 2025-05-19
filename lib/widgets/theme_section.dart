import 'package:flutter/material.dart';

class ThemeSetting {
  final IconData? icon;
  final String title;
  final String? subTitle;
  final bool? value;
  final void Function(bool)? onChanged;
  final void Function()? onTap;
  bool enabled;

  ThemeSetting({
    this.icon,
    required this.title,
    this.subTitle,
    this.value,
    this.onChanged,
    this.onTap,
    this.enabled = true,
  });
}

class ThemeSettings {
  final String themeTitle;
  final List<ThemeSetting> themeSetting;

  ThemeSettings({required this.themeTitle, required this.themeSetting});
}
