// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

customAppBar(String title, BuildContext context,
    {bool hasBack = true, PreferredSizeWidget? bottom}) {
  return AppBar(
    bottom: bottom,
    leading: hasBack
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              // color: Constants.secondaryColor,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )
        : SizedBox(
            height: 1,
          ),
    backgroundColor: Constants.mainColor,
    title: Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 0.0,
  );
}
