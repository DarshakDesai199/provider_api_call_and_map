import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider_demo/provider/theme_change_controller.dart';

class AppColor {
  // static Color purple = Color.fromRGBO(33, 87, 0, 6);
  static Color purple = ThemeController().themeMode == ThemeMode.light
      ? Color(0xffa020f0)
      : Color.fromRGBO(33, 87, 0, 6);
}
