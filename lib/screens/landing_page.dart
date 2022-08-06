// ignore_for_file: prefer_const_constructors, unused_import
// @dart=2.9

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/screens/settingsScreen.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  _widget(int page) {
    final user = Provider.of<UserProvider>(context, listen: false);

    switch (page) {
      case 0:
        return Container();
      case 1:
        return Container();
      case 2:
        return SettingsScreen();
      case 4:
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text("LandingPage"),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color iconColors =
        themeProvider.isLightTheme ? Constants.mainColor : Colors.white;
    TextStyle textStyle = GoogleFonts.montserrat(
      color: iconColors,
      fontSize: 13,
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: _widget(_currentIndex),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(
                Icons.home_rounded,
              ),
              title: Text(
                'Home',
                style: textStyle,
              ),
              activeColor: iconColors,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.account_balance_rounded,
              ),
              title: Text(
                'Accounts',
                style: textStyle,
              ),
              activeColor: iconColors,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.settings_rounded,
              ),
              title: Text(
                'Settings',
                style: textStyle,
              ),
              activeColor: iconColors,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
