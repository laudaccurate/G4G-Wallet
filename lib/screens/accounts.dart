// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/screens/Home/home_page.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAccounts extends StatefulWidget {
  const MyAccounts({Key? key}) : super(key: key);

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: Constants.mainColor,
            ),
          ),
          ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.06),
                Text(
                  'MY ACCOUNTS',
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ...MockData.accounts
                .map(
                  (acc) => AccountWidget(account: acc),
                )
                .toList(),
          ]),
        ]),
      ),
    );
  }
}
