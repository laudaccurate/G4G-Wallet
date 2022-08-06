// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_if_null_operators
// @dart=2.9

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gfg_wallet/models.dart/loginModel.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/dialog.dart';
import 'package:gfg_wallet/utils/global_services.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/serviceLocator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  UserData user;
  var settings = new GlobalKey<ScaffoldState>();
  double _screenHeight;
  double _screenWidth;
  LocalStorageService storageService = locator<LocalStorageService>();
  FlashController<dynamic> cont;

  bool get fbState => storageService.fastBalance;
  bool get blState => storageService.bioLogin;

  Map<String, dynamic> secQuestion;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final def = Provider.of<Globals>(context, listen: false);
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: RepaintBoundary(
            key: settings,
            child: def.getLoading
                ? SpinKitCircle(
                    color: Constants.mainColor,
                  )
                : Container(
                    height: _screenHeight,
                    width: _screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bk2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      height: _screenHeight,
                      width: _screenWidth,
                      decoration: BoxDecoration(
                          color: themeProvider.themeData().backgroundColor),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SettingTile(
                            label: 'Change Password',
                            color: Colors.red,
                            icon: Icons.lock_open,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),
                          SettingTile(
                            label: 'Change PIN Code',
                            color: Colors.blueGrey,
                            icon: Icons.pin_outlined,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),

                          SettingTile(
                            label: 'Biometric Activation',
                            color: Colors.deepPurple,
                            icon: CupertinoIcons.lock_shield,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  blState ? 'ON' : 'OFF',
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                CupertinoSwitch(
                                  activeColor: Constants.mainColor,
                                  value: blState,
                                  onChanged: (state) {
                                    storageService.bioLogin = true;
                                  },
                                )
                              ],
                            ),
                            func: () {},
                          ),
                          SettingTile(
                            label: 'Forgot PIN Code',
                            color: Colors.green,
                            icon: Icons.password_outlined,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),

                          SettingTile(
                            label: 'Dark Mode',
                            color: themeProvider.isLightTheme
                                ? Colors.grey[800]
                                : Colors.grey[400],
                            icon: themeProvider.isLightTheme
                                ? Icons.dark_mode
                                : Icons.light_mode_rounded,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  !themeProvider.isLightTheme ? 'ON' : 'OFF',
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                CupertinoSwitch(
                                  activeColor: Constants.mainColor,
                                  value: !themeProvider.isLightTheme,
                                  onChanged: (state) async {
                                    await themeProvider.toggleThemeData();
                                  },
                                )
                              ],
                            ),
                            func: () {},
                          ),

                          // SettingTile(
                          //   label: 'Enquiry',
                          //   color: Colors.brown,
                          //   icon: Icons.live_help_rounded,
                          //   func: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //     builder: (context) => Enquiry(type: 'e'),
                          //     //   ),
                          //     // );
                          //   },
                          // ),
                          SettingTile(
                            label: 'Tarrif List',
                            icon: Icons.bar_chart,
                            color: Colors.black,
                            func: () {
                              GlobalServices().launchURL(
                                  'https://rokelbank.sl/Simkorpor/tarrifagentslist/tarrif.pdf');
                            },
                          ),

                          SettingTile(
                            label: 'Help (FAQs)',
                            icon: Icons.help_outline,
                            color: Colors.amber,
                            func: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => FAQs(),
                              //   ),
                              // );
                            },
                          ),
                          SettingTile(
                            label: 'Terms & Conditions',
                            icon: Icons.rule_sharp,
                            color: Colors.blue,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),
                          SettingTile(
                            label: 'Share with Friends',
                            icon: Icons.share_rounded,
                            color: Colors.deepOrange,
                            func: () {
                              // Future.delayed(const Duration(milliseconds: 30),
                              //     () async {
                              //   Share.share(
                              //     'RCBank Mobile',
                              //     subject:
                              //         'Link to download RCBank Mobile from PlayStore or AppStore.',
                              //   );
                              // });
                            },
                          ),
                          SettingTile(
                            label: 'Contact Us',
                            icon: Icons.contact_phone_outlined,
                            color: Colors.indigo,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(0.0),
                                ),

                                // padding: EdgeInsets.symmetric(
                                //   horizontal: 16.0,
                                //   vertical: 10.0,
                                // ),
                                // highlightedBorderColor: Colors.red.shade200,
                                // borderSide: BorderSide(color: Colors.transparent),
                                onPressed: () =>
                                    CustomDialogs.showLogoutDialog(context),
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red.shade400,
                                  size: 20.0,
                                ),

                                label: Text(
                                  "LOGOUT",
                                  style: GoogleFonts.comfortaa(
                                    color: Colors.red.shade400,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "G4G Wallet Version ${Constants.version}",
                                style: GoogleFonts.comfortaa(
                                  color: Colors.grey.shade400,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}

class SettingTile extends StatefulWidget {
  final String label;
  final String image;
  final Function func;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Widget trailing;

  final bool hideBorder;
  const SettingTile(
      {Key key,
      this.label,
      this.image,
      this.func,
      this.color,
      this.textColor,
      this.icon,
      this.trailing,
      this.hideBorder = false})
      : super(key: key);

  @override
  _SettingTileState createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  bool fbState = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          if (widget.func != null) {
            widget.func();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.hideBorder
                    ? Colors.transparent
                    : themeProvider.isLightTheme
                        ? Colors.grey[200]
                        : Colors.grey[500],
              ),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              decoration: BoxDecoration(
                boxShadow: themeProvider.themeMode().shadow,
                color: widget.textColor != null
                    ? Colors.white
                    : widget.color.withOpacity(0.85),
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.all(6.0),
              child: widget.image != null
                  ? Image.asset(
                      'assets/images/${widget.image}',
                      width: 23,
                      height: 23,
                    )
                  : Icon(
                      widget.icon,
                      color: widget.textColor == null
                          ? Colors.white
                          : widget.color.withOpacity(0.85),
                      size: 23.0,
                    ),
            ),
            title: Text(
              widget.label,
              style: GoogleFonts.comfortaa(
                  fontSize: 14.5,
                  color: themeProvider.themeMode().textColor,
                  fontWeight: FontWeight.w500),
            ),
            trailing: widget.trailing == null
                ? Icon(
                    CupertinoIcons.chevron_right,
                    color: themeProvider.isLightTheme
                        ? Colors.black54
                        : Colors.grey[300],
                    size: 22.0,
                  )
                : widget.trailing,
          ),
        ),
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key key,
    @required double screenWidth,
    @required double screenHeight,
  })  : _screenWidth = screenWidth,
        _screenHeight = screenHeight,
        super(key: key);

  final double _screenWidth;
  final double _screenHeight;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => UserProfileScreen(),
      //   ),
      // ),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(25.0),
        color: Constants.mainColor.withOpacity(0.7),
        elevation: 2.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/background2.jpg"),
            ),
          ),
          child: Container(
            width: _screenWidth * 0.64,
            height: _screenHeight * 0.22,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
              // backgroundBlendMode: BlendMode.lighten,
              borderRadius: BorderRadius.circular(25.0),
              color: Constants.mainColor.withOpacity(0.7),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Row(
                    children: [
                      PhysicalModel(
                        color: Colors.blue.withOpacity(0.7),
                        shape: BoxShape.circle,
                        shadowColor: Colors.grey[600],
                        elevation: 3.0,
                        // child: ProfilePicWidget(radius: 70),
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            user.getUser.userAlias,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
