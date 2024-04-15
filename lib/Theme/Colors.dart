import 'package:flutter/material.dart';

class ColorsLists extends ChangeNotifier {
  static final ColorsLists _instance = ColorsLists._internal();

  factory ColorsLists() {
    return _instance;
  }

  ColorsLists._internal();

  Map<String, List<Color>> allThemes = {
    'DefaultDark': [
      Color(0xFF020E1D),
      Color.fromARGB(255, 245, 62, 117),
      Color(0xFF5D0E41),
      Colors.white,
      Colors.white.withOpacity(0.8)
    ],
    'SecondaryDark': [
      Color.fromARGB(255, 22, 26, 32),
      Color(0xFF76ABAE),
      Color(0xFF31363F),
      Colors.white,
      Colors.white.withOpacity(0.8)
    ],
    'DefaultLight': [
      Color(0xFFF6F5F2),
      Color.fromARGB(255, 241, 111, 137),
      Color.fromARGB(255, 241, 179, 192),
      Color.fromARGB(255, 77, 35, 43),
      Color.fromARGB(255, 77, 35, 43).withOpacity(0.8)
    ],
    'SecondaryLight': [
      Color(0xFFEEF5FF),
      Color(0xFF176B87),
      Color(0xFFB4D4FF),
      Color.fromARGB(255, 11, 51, 65),
      Color.fromARGB(255, 11, 51, 65).withOpacity(0.8)
    ],
  };

  List<Color> _selectedTheme = [
    Color(0xFF020E1D),
    Color(0xFFA0153E),
    Color(0xFF5D0E41),
    Colors.white,
    Colors.white.withOpacity(0.8)
  ];
  List<Color> get selectedTheme => _selectedTheme;

  void changeTheme(Map<String, List<Color>> allThemes, String themeName,
      List<Color> selectedTheme) {
    if (allThemes.containsKey(themeName)) {
      selectedTheme.clear();
      selectedTheme.addAll(allThemes[themeName]!);
    } else {
      print('Theme $themeName not found!');
    }
    notifyListeners();
  }

  Color lighten(Color color, [double amount = .2]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color darken(Color color, [double amount = .05]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
