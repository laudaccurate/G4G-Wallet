// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers
// @dart=2.9

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gfg_wallet/screens/loginScreen.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDialogs {
  static info(BuildContext context, String message) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.TOPSLIDE,
            // tittle: '',
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            // desc: message,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {})
        .show();
  }

  static void showLogoutDialog(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    LocalStorageService storageService = locator<LocalStorageService>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Container(
            height: screenHeight * 0.06,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
            ),
            color: Constants.mainColor,
            child: Center(
              child: Text(
                'Confirm Logout'.toUpperCase(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
          content: Container(
            height: screenHeight * 0.12,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.02,
            ),
            child: Center(
              child: Text(
                'Are you sure you want to \nlogout?',
                style: TextStyle(
                  fontSize: 17.0,
                  color: themeProvider.isLightTheme
                      ? Colors.black54
                      : Colors.grey[300],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Theme.of(dialogContext).primaryColor,
              child: Text(
                'Cancel'.toUpperCase(),
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.red[600],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: themeProvider.themeMode().textColor,
              child: Text(
                'Logout'.toUpperCase(),
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                storageService.isLoggedIn = false;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            )
          ],
        );
      },
    );
  }

  static void customSuccessDialog(
    BuildContext context,
    String title,
    String label,
    VoidCallback function,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          descriptions: label,
          text: "OK",
          function: function,
        );
      },
    );
  }

  success(BuildContext context, String message, Function function) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.TOPSLIDE,
            // tittle: '',
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            // desc: message,
            // btnCancelOnPress: () {},
            btnOkOnPress: function)
        .show();
  }

  error(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      // tittle: '',
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      // desc: message,
      btnCancelOnPress: () {},
      // btnOkOnPress: () {}
    ).show();
  }
}
/*
logout(BuildContext context, String message) {
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      tittle: '',
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      // desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        String user = await loadDataN();
        if (user == null || user.length <= 1 || user.isEmpty) {
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      name: user,
                    )),
            ModalRoute.withName("/"),
          );
        }
      }).show();
}*/

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final VoidCallback function;
  final Image img;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.function})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox>
    with TickerProviderStateMixin {
  Animation<double> logoAnimation;
  AnimationController logoController;

  @override
  void initState() {
    super.initState();
    logoController = AnimationController(
      duration: Duration(milliseconds: 4000),
      vsync: this,
      value: 0.4,
    );

    logoAnimation = CurvedAnimation(
      parent: logoController,
      curve: Curves.bounceInOut,
    );

    logoController.forward();

    logoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        logoController.reverse();
        logoController.repeat();
      }
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    // logoAnimation.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.dialogPadding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.dialogPadding,
              top: Constants.dialogAvatarRadius + Constants.dialogPadding,
              right: Constants.dialogPadding,
              bottom: Constants.dialogPadding),
          margin: EdgeInsets.only(top: Constants.dialogAvatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: themeProvider.themeData().backgroundColor,
              borderRadius: BorderRadius.circular(Constants.dialogPadding),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[800],
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: GoogleFonts.comfortaa(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: themeProvider.isLightTheme
                        ? Colors.grey[700]
                        : Colors.grey[300]),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: GoogleFonts.montserrat(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: widget.function ?? () => Navigator.pop(context),
                  child: Text(
                    widget.text,
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.dialogPadding + 10,
          right: Constants.dialogPadding + 10,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            backgroundImage: AssetImage("assets/images/statement_success.gif"),
            radius: Constants.dialogAvatarRadius,
            // child:
            // ScaleTransition(
            //   scale: logoAnimation,
            //   alignment: Alignment.center,
            //   child: Icon(
            //     Icons.check_rounded,
            //     color: Colors.white,
            //     size: 50.0,
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
