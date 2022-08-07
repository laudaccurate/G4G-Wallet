// @dart=2.9

// ignore_for_file: unnecessary_new, prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'dart:convert';
import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/widgets/appBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Utilities {
  static String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow < 12) {
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  static String formatAmounts(dynamic amt) {
    String formattedAmt;
    final formatter = NumberFormat("#,##0.00", "en_US");
    // final formatter = new NumberFormat.simpleCurrency();

    if (amt == null || amt.isEmpty || amt == '0') {
      amt = "0,000.00";
      formattedAmt = amt;
    } else {
      double amtDouble = double.parse(amt);
      formattedAmt = formatter.format(amtDouble);
    }

    return formattedAmt;
  }

  static String fullDate(DateTime date) {
    if (date != null) {
      return DateFormat("EEEE, d MMMM yyyy, ").format(date) +
          DateFormat.jm().format(date);
      // return DateFormat.d().add_yMMM().format(date);
    } else {
      return "N/A";
    }
  }

  static String phoneNumber(PhoneNumber number) {
    String _number = number.number.replaceAll(RegExp(r"\s+"), "");
    _number = _number.replaceAll(')', '');
    _number = _number.replaceAll('(', '');
    _number = _number.replaceAll('-', '');
    _number = _number.replaceAll('+', '');

    return _number;
  }

  static String accNum(String acc) {
    int length = acc.length;
    String start = acc.substring(0, 3);
    String end = acc.substring(length - 3, length);
    int mask = length - 6;
    String hash = "*" * mask;
    return start + hash + end;
  }

  static String formatCardNo(String cardNo) {
    String _cardNo = cardNo.substring(0, 4) +
        cardNo
            .substring(4, cardNo.length - 4)
            .replaceAll(RegExp(r'[0-9]'), '*') +
        cardNo.substring(cardNo.length - 4);

    StringBuffer formattedCardNumber = StringBuffer();
    for (int i = 0; i < _cardNo.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedCardNumber.write(" ");
      }
      formattedCardNumber.write(_cardNo[i]);
    }

    return formattedCardNumber.toString();
  }

  Future<String> imageToBase64(File path) async {
    // File file = await testCompressAndGetFile(path, "Elijah");

    List<int> imageBytes = await path.readAsBytes();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static String getAccountTypes(String data) {
    var newdata = data.split("- ");
    return newdata[1];
  }

  // static String accountstypesname(String data) {
  //   var newdata = data.split("A - ");
  //   return newdata[1];
  // }

  static String accountstypesname(String data) {
    var newdata = data.split("-");
    if (newdata.length > 2) {
      return newdata[2];
    } else {
      return newdata[1];
    }
  }

  static String dateFormat(DateTime date) {
    return DateFormat("d-MMM-yyyy").format(date);
    // return DateFormat.d().add_yMMM().format(date);
  }

  static String newdateFormat(DateTime date) {
    return DateFormat("yyyy-M-dd").format(date);
    // return DateFormat.yMMMd().format(_date);
  }

  static String fullDateFormat(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    // return DateFormat.yMMMd().format(_date);
  }

  static String yearMD(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
    // return DateFormat.d().add_yMMM().format(date);
  }

  static String getNextDay(String date) {
    var dateList = date.split('-');
    int year = int.parse(dateList[0]);
    int month = int.parse(dateList[1]);
    int day = int.parse(dateList[2]);

    var realDate = new DateTime(year, month, day);
    return newdateFormat(realDate.add(new Duration(days: 1)));
  }

  static String graphdateFormat(DateTime date) {
    return DateFormat("d/M/yy").format(date);
    // return DateFormat.d().add_yMMM().format(date);
  }

  static openContainer(
      {BuildContext context,
      Widget child,
      Color color,
      Widget display,
      String label}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return OpenContainer(
      closedElevation: 10,
      transitionDuration: Duration(milliseconds: 600),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      closedColor: themeProvider.themeData().backgroundColor,
      openColor: themeProvider.themeData().backgroundColor,
      // openColor: Colors.white,
      // closedColor: Colors.white,
      closedBuilder: (context, openBuilder) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.16,
              // margin: const EdgeInsets.only(top: 20, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: themeProvider.themeMode().shadow,
                color: color,
              ),
              child: child,
            ),
            SizedBox(height: 7),
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: themeProvider.themeMode().textColor,
              ),
            )
          ],
        );
      },
      openBuilder: (context, closeBuilder) {
        return Scaffold(
          appBar: customAppBar(label, context),
          body: display,
        );
      },
    );
  }

  static void selectAccount({
    BuildContext context,
    List<AccountModelDatum> accounts,
    Function(AccountModelDatum) onAcctSelected,
    int selectedAcc,
  }) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: screenHeight * (0.11 * accounts.length + 0.25),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.001,
                vertical: screenHeight * 0.000,
              ),
              decoration: BoxDecoration(
                color: themeProvider.themeData().backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.001,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.004),
                    Container(
                      width: screenWidth * 0.12,
                      height: screenHeight * 0.0035,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Option",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.themeMode().textColor),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.003),
                    Text(
                      'Tap on the preferred option to select it',
                      style: TextStyle(fontSize: 13.3, color: Colors.grey[500]),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Expanded(
                      child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: ((context, index) => Container()),
                        // itemBuilder: (context, index) => AccountSelectionTile(
                        //   account: accounts[index],
                        //   index: index,
                        //   selectedIndex: selectedAcc,
                        //   onActivated: () {
                        //     Navigator.of(context).pop();
                        //     onAcctSelected(accounts[index]);
                        //   },
                        // ),
                      ),
                    ),
                    // SizedBox(height: _screenHeight * 0.002),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Color getColor(String type) {
    switch (type) {
      case "A":
        return Colors.green;

      case "B":
        return Colors.red;

      case "C":
        return Colors.yellow.shade800;

      default:
        return Colors.purpleAccent;
    }
  }

  static List<Color> getGradientColor(String type) {
    switch (type) {
      case "A":
        return [Colors.green.shade300, Colors.green];

      case "B":
        return [Colors.red.shade300, Colors.red];

      case "C":
        return [Colors.yellow.shade300, Colors.yellow];

      default:
        return [Colors.purpleAccent, Colors.purpleAccent.shade100];
    }
  }
}
