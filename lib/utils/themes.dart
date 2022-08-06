// we use provider to manage the app state
// @dart=2.9
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({@required this.isLightTheme});

  // the code below is to manage the status bar color when the theme changes
  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF26242e),
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  // use to toggle the theme
  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

//return true for lightMode
  getThemeType() {
    return isLightTheme;
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(
          brightness: isLightTheme ? Brightness.light : Brightness.dark,
        ).textTheme,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : const Color(0xFF1E1F28),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor:
          isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF26242e),
      scaffoldBackgroundColor:
          isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF26242e),
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      backgroundColor: Colors.white,
      gradient: [
        if (isLightTheme) ...const [Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...const [Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? Colors.grey[600] : Color(0xFFFFFFFF),
      toggleButtonColor:
          isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFf34323d),
      toggleBackgroundColor:
          isLightTheme ? const Color(0xFFe7e7e8) : const Color(0xFF222029),
      // shadow: [
      //   if (isLightTheme)
      //     const BoxShadow(
      //         color: Color(0xFFd8d7da),
      //         spreadRadius: 5,
      //         blurRadius: 10,
      //         offset: Offset(0, 5)),
      //   if (!isLightTheme)
      //     const BoxShadow(
      //         color: Color(0x66000000),
      //         spreadRadius: 5,
      //         blurRadius: 10,
      //         offset: Offset(0, 5))
      // ],
      shadow: [
        if (isLightTheme) ...[
          BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1.0),
        ],
        if (!isLightTheme) ...[
          BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1.0),
          BoxShadow(
              color: const Color(0xFf34323d),
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1.0),
        ]
      ],
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    @required this.gradient,
    @required this.backgroundColor,
    @required this.toggleBackgroundColor,
    @required this.toggleButtonColor,
    @required this.textColor,
    @required this.shadow,
  });
}

// Provider finished
