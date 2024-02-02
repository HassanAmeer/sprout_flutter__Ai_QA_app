import 'package:flutter/material.dart';

class AppDecorations {
  static MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static List<BoxShadow> appShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 10,
        spreadRadius: 5,
        offset: const Offset(2, 5),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.04),
        blurRadius: 10,
        spreadRadius: 5,
        offset: const Offset(-2, -5),
      ),
    ];
  }

  static List<BoxShadow> chatShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 5,
        spreadRadius: 2.5,
        offset: const Offset(1, 3),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.02),
        blurRadius: 5,
        spreadRadius: 2.5,
        offset: const Offset(-1, -3),
      ),
    ];
  }

  static List<BoxShadow> ImageShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        offset: const Offset(0, 4),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ];
  }
}
