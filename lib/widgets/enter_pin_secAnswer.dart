// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, invalid_required_positional_param, prefer_if_null_operators, no_leading_underscores_for_local_identifiers
// @dart=2.9

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/widgets/pin_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Label extends StatelessWidget {
  final String label;

  const Label(this.label) : super();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(4, 1, 0, 8),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: themeProvider.isLightTheme
                ? Colors.grey.shade600
                : Colors.grey.shade400),
      ),
    );
  }
}

class BSheetItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function action;
  final dynamic data;
  final Widget widget;

  BSheetItem(
      {this.data,
      this.widget,
      this.title,
      this.subtitle,
      this.icon,
      this.action});
}

customBottomSheet(
    {BuildContext context,
    List<BSheetItem> items,
    double height,
    String title}) {
  double _screenHeight = MediaQuery.of(context).size.height;
  double _screenWidth = MediaQuery.of(context).size.width;
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: height ?? _screenHeight * (0.365),
            padding: EdgeInsets.symmetric(
                horizontal: _screenWidth * 0.001,
                vertical: _screenHeight * 0.0003),
            decoration: BoxDecoration(
              color: themeProvider.themeData().backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _screenWidth * 0.04,
                vertical: _screenHeight * 0.006,
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
                  SizedBox(height: _screenHeight * 0.001),
                  Container(
                    width: _screenWidth * 0.12,
                    height: _screenHeight * 0.0035,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  SizedBox(height: _screenHeight * 0.015),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.themeMode().textColor),
                    ),
                  ),
                  SizedBox(height: _screenHeight * 0.003),
                  Text(
                    'Tap on the preferred option to proceed',
                    style: GoogleFonts.montserrat(
                        fontSize: 13.3, color: Colors.grey[500]),
                  ),
                  SizedBox(height: _screenHeight * 0.03),
                  Expanded(
                    child: Column(
                      children: items
                          .map(
                            (item) => OpenContainer(
                              closedElevation: 0,
                              transitionDuration: Duration(milliseconds: 600),
                              closedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              closedColor:
                                  themeProvider.themeData().backgroundColor,
                              openColor:
                                  themeProvider.themeData().backgroundColor,
                              closedBuilder: (context, openBuilder) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.0,
                                    horizontal: 4.0,
                                  ),
                                  margin: EdgeInsets.only(bottom: 13),
                                  decoration: BoxDecoration(
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: themeProvider.isLightTheme
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      item.icon,
                                      size: 30,
                                      color: Constants.mainColor,
                                    ),
                                    title: Text(
                                      item.title,
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            themeProvider.themeMode().textColor,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item.subtitle,
                                      style: GoogleFonts.comfortaa(
                                        color: Colors.grey[400],
                                        fontSize: 13,
                                      ),
                                    ),
                                    onTap: item.action != null
                                        ? item.action
                                        : null,
                                  ),
                                );
                              },
                              openBuilder: (context, closeBuilder) {
                                return item.widget;
                              },
                            ),
                          )
                          .toList(),
                      // Divider(color: Colors.grey[400], height: 8.0),
                    ),
                  ),
                  SizedBox(height: _screenHeight * 0.002),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

confirmationScreen(
    {@required BuildContext context,
    @required Map data,
    @required TextEditingController pinController,
    @required Function onSubmit,
    @required String amount}) async {
  final _globals = Provider.of<Globals>(context, listen: false);
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  bool saveBeneficiary = false;

  return await showCupertinoModalPopup(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      double _screenHeight = MediaQuery.of(context).size.height;

      return SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Confirm Transaction'.toUpperCase(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: themeProvider.isLightTheme
                                            ? Constants.secondaryColor
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close_rounded),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      pinController.clear();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ...data.entries
                              .toList()
                              .map(
                                (entry) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13.0,
                                      horizontal: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey[400]),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${entry.key}  ",
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            entry.value.toUpperCase(),
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: themeProvider.isLightTheme
                                                  ? Colors.grey[700]
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          // StatefulBuilder(
                          //   builder: (BuildContext context, setState) {
                          //     return SettingTile(
                          //       label: 'Save Beneficiary',
                          //       hideBorder: true,
                          //       icon: Icons.person,
                          //       color: Colors.green,
                          //       trailing: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           Text(
                          //             saveBeneficiary ? 'YES' : 'NO',
                          //             style: TextStyle(
                          //               color: Colors.grey[300],
                          //               fontSize: 15.0,
                          //               fontWeight: FontWeight.w600,
                          //             ),
                          //           ),
                          //           SizedBox(width: 5.0),
                          //           CupertinoSwitch(
                          //             activeColor: Constants.mainColor,
                          //             value: saveBeneficiary,
                          //             onChanged: (state) {
                          //               setState(() {
                          //                 saveBeneficiary = state;
                          //               });

                          //               // toggleFastBalance(state);
                          //             },
                          //           )
                          //         ],
                          //       ),
                          //       func: () {},
                          //     );
                          //   },
                          // ),
                          SizedBox(height: 30),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Label('Enter transaction pin'),
                          // ),
                          SizedBox(height: 10),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: PinputField(
                          //     controller: pinController,
                          //     label: 'Enter PIN',
                          //     obscure: true,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: _screenHeight * 0.02),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: InfoCard(
                  //     info:
                  //         "By entering your transaction pin, you agree to abide by the Terms and Conditions",
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.green,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: double.infinity,
                    // height: 100,
                    child: RaisedButton(
                      elevation: 0,
                      highlightElevation: 0,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.green,
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PinCodeVerificationScreen(
                              onSubmit: onSubmit,
                              pinController: pinController,
                              email: '',
                              phoneNumber: '',
                            ),
                          ),
                        );
                      },
                      child: _globals.getLoading
                          ? SpinKitCircle(
                              color: Colors.white,
                              size: 22.0,
                            )
                          : Text(
                              'Confirm'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                  /*Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Constants.mainColor,

                          padding: EdgeInsets.only(bottom: 15),
                          // height: 100,
                          child: RaisedButton(
                            elevation: 0,
                            highlightElevation: 0,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: Constants.mainColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: _globals.getLoading
                                ? SpinKitCircle(
                                    color: Colors.white,
                                    size: 22.0,
                                  )
                                : Text(
                                    'Cancel'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.green,
                          padding: EdgeInsets.only(bottom: 15),

                          // height: 100,
                          child: RaisedButton(
                            elevation: 0,
                            highlightElevation: 0,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: _globals.getLoading
                                ? SpinKitCircle(
                                    color: Colors.white,
                                    size: 22.0,
                                  )
                                : Text(
                                    'Confirm'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class DescriptionTitle extends StatelessWidget {
  final String description;

  const DescriptionTitle({Key key, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Divider(
                height: 2.0,
                thickness: 1.0,
                color: Constants.mainColor.withOpacity(0.3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
              description,
              style: GoogleFonts.comfortaa(
                fontSize: 12,
                letterSpacing: 0.4,
                fontWeight: FontWeight.bold,
                color: Constants.mainColor.withOpacity(0.9),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Divider(
                height: 2.0,
                thickness: 1.0,
                color: Constants.mainColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
