import 'dart:ui';
import 'package:flutter/material.dart';

class ThemeHelper {
  static bool darkModeActive({BuildContext? context}) {
    if (context != null) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      return PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    }
  }
}
