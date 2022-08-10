// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors
// @dart=2.9

import 'package:flutter/material.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class InfoCard extends StatelessWidget {
  final String info;

  const InfoCard({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color color = themeProvider.isLightTheme
        ? Colors.lightBlue[50]
        : Colors.white.withOpacity(1);
    Color textcolor =
        themeProvider.isLightTheme ? Colors.blueGrey : Constants.mainColor;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: textcolor,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: GoogleFonts.montserrat(
                color: textcolor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard2 extends StatelessWidget {
  final String info;

  const InfoCard2({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCardCustomize extends StatelessWidget {
  final String info;
  final Color color;

  const InfoCardCustomize({
    @required this.info,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
