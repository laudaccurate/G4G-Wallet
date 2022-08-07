// @dart=2.9
// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:provider/provider.dart';

class AccountSelectionTile extends StatefulWidget {
  final AccountModelDatum account;
  final beneficiary;
  final int selectedIndex;
  final int index;
  final Function onActivated;

  const AccountSelectionTile(
      {Key key,
      this.account,
      this.onActivated,
      this.beneficiary,
      this.selectedIndex,
      this.index})
      : super(key: key);
  @override
  _AccountSelectionTileState createState() => _AccountSelectionTileState();
}

class _AccountSelectionTileState extends State<AccountSelectionTile> {
  double _screenHeight;
  double _screenWidth;
  bool isAccount;
  Color color;
  var data;

  @override
  void initState() {
    super.initState();
    isAccount = widget.account != null;
    data = isAccount ? widget.account : widget.beneficiary;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    // switch (data.accountType) {
    //   case 'CURRENT ACCOUNT - STAFF':
    //     color = CupertinoColors.activeBlue.withOpacity(0.8);
    //     break;
    //   case 'SAVINGS ACCOUNT':
    //     color = CupertinoColors.activeGreen.withOpacity(0.8);
    //     break;
    //   case 'Investment Account':
    //     color = CupertinoColors.activeOrange.withOpacity(0.8);
    //     break;
    //   default:
    // }

    Color color = Constants.mainColor;

    // RandomColor().randomColor(
    //   colorHue: ColorHue.green,
    //   colorSaturation: ColorSaturation.mediumSaturation,
    //   colorBrightness: ColorBrightness.light,
    // );

    return GestureDetector(
      onTap: () => widget.onActivated(),
      child: Container(
        height: _screenHeight * 0.105,
        width: _screenWidth * 0.88,
        padding: EdgeInsets.only(
          left: _screenWidth * 0.03,
          right: _screenWidth * 0.01,
          top: _screenWidth * 0.01,
        ),
        margin: EdgeInsets.only(bottom: _screenHeight * 0.025),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: themeProvider.isLightTheme ? Colors.grey[300] : Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              foregroundColor: Colors.white,
              child: Text(
                widget.account.accountDesc.substring(0, 1).toUpperCase(),
              ),
            ),
            SizedBox(width: _screenWidth * 0.03),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.account.accountType,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: themeProvider.themeMode().textColor,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.account.accountNumber,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: _screenHeight * 0.003),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(right: 5.0),
                        child: Text(
                          // isAccount
                          //     ?
                          "${widget.account.currency}  " +
                              Utilities.formatAmounts(
                                  widget.account.availableBalance),
                          // : data.account,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: themeProvider.isLightTheme
                                ? Constants.mainColor
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (widget.index == widget.selectedIndex) ...[
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  color: themeProvider.isLightTheme
                      ? Constants.mainColor
                      : Colors.white,
                  size: 18.0,
                ),
              ),
            ]
          ],
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       cardState = !cardState;
    //       widget.onActivated(cardState);
    //     });
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('assets/images/background2.jpg'),
    //         fit: BoxFit.fill,
    //         // colorFilter: ColorFilter.mode(Colors.blue, BlendMode.difference),
    //       ),
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(25.0),
    //       ),
    //       // color: Color(0XFF339933).withOpacity(0.3),
    //     ),
    //     child: Container(
    //       height: _screenHeight * 0.2,
    //       // width: _screenWidth * 0.58,
    //       // margin: EdgeInsets.symmetric(horizontal: _screenWidth * 0.04),
    //       padding: EdgeInsets.symmetric(
    //           vertical: _screenHeight * 0.01, horizontal: _screenWidth * 0.025),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(25.0),
    //         ),
    //         color: color.withOpacity(0.75),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Image(
    //                 image: AssetImage("assets/images/akrblogo_big.png"),
    //                 width: _screenWidth * 0.08,
    //                 height: _screenHeight * 0.04,
    //               ),
    //               SizedBox(width: 15.0),
    //               Expanded(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Flexible(
    //                       child: Text(
    //                         widget.account.accountName,
    //                         textAlign: TextAlign.start,
    //                         style: TextStyle(
    //                           color: Colors.white.withOpacity(0.95),
    //                           fontSize: 15.0,
    //                           fontWeight: FontWeight.w500,
    //                           letterSpacing: 0.4,
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(width: 10.0),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 25.0),
    //           Row(
    //             children: [
    //               SizedBox(width: 40.0),
    //               Text(
    //                 widget.account.accountNumber,
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   color: Colors.white.withOpacity(0.8),
    //                   fontSize: 18.0,
    //                   fontWeight: FontWeight.w600,
    //                   letterSpacing: 0.6,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           // SizedBox(height: _screenHeight * 0.001),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Expanded(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Flexible(
    //                       // width: _screenWidth * 0.8,
    //                       child: Text(
    //                         widget.account.accountType.toUpperCase(),
    //                         textAlign: TextAlign.start,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(
    //                           fontSize: 15.0,
    //                           color: Colors.white70,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               // SizedBox(width: 50.0),
    //               Switch.adaptive(
    //                   value: cardState,
    //                   onChanged: (val) {
    //                     setState(() {
    //                       cardState = !cardState;
    //                     });
    //                     widget.onActivated(cardState);
    //                   })
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
