// @dart=2.9

// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, unused_field, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/provider/phoneDetails.dart';
import 'package:gfg_wallet/screens/loginScreen.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool error = false;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics;
  AnimationController _controller;
  Animation<double> _animation;

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        availableBiometrics = availableBiometrics;
      });
    }
  }

  bool isLoading = false;
  var deviceId;
  var deviceIp;
  var model;
  var manufacturer;
  var brand;
  var country;
  var longitude;
  var latitude;
  String deviceOS;
  var appVersion;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<void> phoneinfo() async {
    try {
      setState(() {
        error = false;
      });
      final response = await http.get(Uri.parse('http://ip-api.com/json'));
      //print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        networkInfo = result;

        deviceIp = result["query"];
        country = result["country"];
        latitude = result["lat"];
        longitude = result["lon"];
      } else {
        if (mounted) {
          setState(() {
            error = true;
          });
        }
        deviceIp = "";
        country = "";
      }
      final phoneInfo = Provider.of<PhoneInfo>(context, listen: false);
      // String token = await FirebaseMessaging.instance.getToken();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo == null) {
        } else {
          deviceId = androidInfo.androidId;
          model = androidInfo.model;
          manufacturer = androidInfo.manufacturer;
          brand = androidInfo.brand;
          deviceOS = "A";
        }
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
        model = iosInfo.model;
        manufacturer = iosInfo.name;
        brand = iosInfo.systemVersion;
        deviceOS = "I";
      }
      //print(deviceId);
      phoneInfo.setbrand(brand);
      phoneInfo.setdeviceID(deviceId);
      phoneInfo.setdeviceOs(deviceOS);
      phoneInfo.setmodel(model);
      phoneInfo.setmanufacturer(manufacturer);
      phoneInfo.setdeviceIp(deviceIp);
      phoneInfo.setcountry(country);
      // _phoneInfo.setFCMToken(token);
      phoneInfo.setLat(latitude);
      phoneInfo.setLng(longitude);
      // print(token);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      });
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          error = true;
        });
      }
    }
  }

  _checkSharedPreference() {
    final globals = Provider.of<Globals>(context, listen: false);
    LocalStorageService storageService = locator<LocalStorageService>();
    storageService.isLoggedIn = false;
    if (storageService.backgroundChanged &&
        storageService.backgroundImage != null) {
      globals.setBkChanged(storageService.backgroundChanged);
      globals.setAppBackground(storageService.backgroundImage);
    }

    if (storageService.profilePic != null) {
      globals.setProfilePic(storageService.profilePic);
    }
  }

  @override
  void initState() {
    super.initState();

    _getAvailableBiometrics();
    _checkSharedPreference();
    phoneinfo();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        value: 0.5,
        lowerBound: 0.7,
        upperBound: 1.0);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bk3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: size.height,
          color: Constants.mainColor.withOpacity(0.85),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 3.0),
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    padding: EdgeInsets.all(4.0),
                    child: ScaleTransition(
                      scale: _animation,
                      child: Image.asset(
                        Constants.logoImage,
                        height: size.height * 0.15,
                        width: size.height * 0.15,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),

                  DefaultTextStyle(
                    style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(Constants.appName,
                            speed: Duration(milliseconds: 100)),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),

                  // Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: error
                  //         ? ElevatedButton(
                  //             child: Text(
                  //               'Reload',
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             onPressed: () {
                  //               phoneinfo();
                  //             },
                  //           )
                  //         : Padding(
                  //             padding: const EdgeInsets.all(20),
                  //             child: LinearProgressIndicator(
                  //               color: Constants.mainColor,
                  //               backgroundColor: Colors.white,
                  //             ),
                  //           )
                  //     // Loader(),
                  //     ),
                  // Align(alignment:Alignment.bottomCenter, child: Container(child: ))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "G4G Wallet © ${DateTime.now().year}",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        // color: Constants.mainColor,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
