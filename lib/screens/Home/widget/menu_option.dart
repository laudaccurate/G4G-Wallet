// @dart=2.9

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuOptions extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Widget display;
  final VoidCallback function;
  const MenuOptions(
      {Key key,
      @required this.label,
      @required this.icon,
      @required this.color,
      @required this.display,
      @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Utilities.openContainer(
      context: context,
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.lato(fontSize: 12),
          ),
        ],
      ),
      label: label,
      display: display,
    );
  }
}
