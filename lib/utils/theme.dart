import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { dark, light }

class ThemeState extends ChangeNotifier {
  bool _isDarkTheme = false;
  ThemeState() {
    getTheme().then((type) {
      _isDarkTheme = type == ThemeType.dark;
      notifyListeners();
    });
  }
  ThemeType get theme => _isDarkTheme ? ThemeType.dark : ThemeType.light;
  set theme(ThemeType type) => setTheme(type);

  void setTheme(ThemeType type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDarkTheme = type == ThemeType.dark;
    bool status = await preferences.setBool('isDark', _isDarkTheme);
    if (status) notifyListeners();
  }

  Future<ThemeType> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDarkTheme = preferences.getBool('isDark') ?? false;
    return _isDarkTheme ? ThemeType.dark : ThemeType.light;
  }
}
