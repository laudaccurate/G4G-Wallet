// @dart=2.9
// ignore_for_file: file_names, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/themes.dart';

// ignore: use_key_in_widget_constructors
class ShimmerLoader extends StatelessWidget {
  final String message;

  const ShimmerLoader({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset(themeProvider.isLightTheme
                  ? 'assets/images/loader.gif'
                  : 'assets/images/loaderDark.gif')),
          const SizedBox(height: 1),
          AutoSizeText(
            message ?? 'Loading...',
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
