import 'package:flutter/material.dart';

class ChangeTheme extends ChangeNotifier{
  bool _themeMode = false;
  bool get themeMode =>_themeMode;
  void toggleThemeMode(){
    _themeMode = !_themeMode;
    notifyListeners();
  }
}