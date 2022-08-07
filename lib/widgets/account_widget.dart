// @dart=2.9

// ignore_for_file: prefer_const_constructors

import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/themes.dart';

class AccountSelectWidget extends StatelessWidget {
  final AccountModelDatum account;

  const AccountSelectWidget({Key key, this.account}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (account != null) {
      return account.accountType != null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: themeProvider.isLightTheme
                    ? Colors.white
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(0.3),
                    blurRadius: 1,
                    offset: Offset(0, 1.0),
                  )
                ],
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        account.accountDesc.toUpperCase(),
                        style: GoogleFonts.comfortaa(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isLightTheme
                              ? Colors.black87
                              : Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        // color: Colors.grey[700],
                      )
                    ],
                  ),
                  Text(account.accountNumber,
                      style: GoogleFonts.comfortaa(
                          fontSize: 13.0,
                          color: themeProvider.isLightTheme
                              ? Colors.grey[700]
                              : Colors.white70,
                          letterSpacing: 1)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(account.accountType,
                        style: GoogleFonts.comfortaa(
                          fontSize: 12.0,
                          color: themeProvider.isLightTheme
                              ? Colors.black45
                              : Colors.white54,
                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          (account.availableBalance == null ||
                                  account.availableBalance.isEmpty)
                              ? ""
                              : '${account.currency} ${Utilities.formatAmounts(account.availableBalance)}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Constants.mainColor,
                            // fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: themeProvider.isLightTheme
                    ? Colors.white
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(0.3),
                    blurRadius: 1,
                    offset: Offset(0, 1.0),
                  )
                ],
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    account.accountNumber,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    account.accountDesc.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[700],
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: themeProvider.isLightTheme
              ? Colors.white
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.3),
              blurRadius: 1,
              offset: Offset(0, 1.0),
            )
          ],
        ),
        width: double.infinity,
        height: 96.0,
        child: Center(
          child: Text(
            'Tap to select account',
            style: GoogleFonts.comfortaa(
              fontSize: 12.0,
              color: themeProvider.isLightTheme
                  ? Colors.grey[700]
                  : Colors.grey[400],
            ),
          ),
        ),
      );
    }
  }
}
