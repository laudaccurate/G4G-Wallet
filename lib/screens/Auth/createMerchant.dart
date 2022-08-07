// @dart=2.9

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gfg_wallet/controllers/AuthController.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/screens/Auth/loginScreen.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';

import 'package:provider/provider.dart';

import '../../utils/styles.dart';

class CreateMerchantScreen extends StatefulWidget {
  final String memberId;

  const CreateMerchantScreen({Key key, this.memberId}) : super(key: key);
  @override
  _CreateMerchantScreenState createState() => _CreateMerchantScreenState();
}

class _CreateMerchantScreenState extends State<CreateMerchantScreen> {
  bool passwordActive = false;
  bool hidePassword = true;
  final login = GlobalKey<ScaffoldState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController tinController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String memberId = '';
  String password = '';

  String validateId() {
    if (userNameController.text != '') {
      return null;
    } else {
      return null;
    }
  }

  String validatePassword() {
    if (passwordController.text != '') {
      return null;
    } else {
      return null;
    }
  }

  double _screenHeight;
  double _screenWidth;

  void showBottomSheet(BuildContext context) {
    int forgot;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: _screenHeight * 0.385,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: _screenHeight * 0.005),
                    Container(
                      width: _screenWidth * 0.15,
                      height: _screenHeight * 0.003,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    SizedBox(height: _screenHeight * 0.034),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'How Can We Help You ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(height: _screenHeight * 0.036),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            forgot = 0;
                          });
                          Future.delayed(const Duration(milliseconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          height: _screenHeight * 0.1,
                          width: _screenWidth * 0.86,
                          padding: EdgeInsets.only(
                              left: _screenWidth * 0.05, right: 4.0, top: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.1,
                              color: Colors.blue,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              forgot != 0
                                  ? Container(
                                      width: _screenWidth * 0.045,
                                      height: _screenHeight * 0.075,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 0.9,
                                            color: Colors.blue,
                                          )),
                                    )
                                  : const Icon(
                                      CupertinoIcons.checkmark_circle_fill,
                                      color: Colors.blue,
                                    ),
                              SizedBox(width: _screenWidth * 0.05),
                              Icon(
                                CupertinoIcons
                                    .person_crop_circle_badge_checkmark,
                                color: Colors.blue,
                                size: _screenHeight * 0.05,
                              ),
                              SizedBox(width: _screenWidth * 0.05),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forgot Member ID',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: _screenHeight * 0.001),
                                  Text(
                                    '  Retrieve Member ID',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 13.5,
                                        color: Colors.grey[400]),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        CupertinoIcons.info_circle,
                                        color: Colors.grey[400],
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: _screenHeight * 0.026),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            forgot = 1;
                          });
                          Future.delayed(const Duration(milliseconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          height: _screenHeight * 0.1,
                          width: _screenWidth * 0.86,
                          padding: EdgeInsets.only(
                              left: _screenWidth * 0.05, right: 4.0, top: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.1,
                              color: Colors.blue,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              forgot != 1
                                  ? Container(
                                      width: _screenWidth * 0.045,
                                      height: _screenHeight * 0.075,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 0.9,
                                            color: Colors.blue,
                                          )),
                                    )
                                  : const Icon(
                                      CupertinoIcons.checkmark_circle_fill,
                                      color: Colors.blue,
                                    ),
                              SizedBox(width: _screenWidth * 0.05),
                              Icon(
                                CupertinoIcons.lock,
                                color: Colors.blue,
                                size: _screenHeight * 0.05,
                              ),
                              SizedBox(width: _screenWidth * 0.05),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: _screenHeight * 0.001),
                                  Text(
                                    '  Create a new password',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 13.5,
                                        color: Colors.grey[400]),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        CupertinoIcons.info_circle,
                                        color: Colors.grey[400],
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: login,
      backgroundColor: Constants.mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _screenHeight * 0.2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: 32,
                      color: Colors.black,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(70.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 158, .3),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      height: _screenHeight * 0.1,
                      width: _screenWidth * 0.22,
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                        iconSize: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: _screenHeight * 0.8,
              width: _screenWidth,
              decoration: BoxDecoration(
                color: themeProvider.themeData().backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _screenWidth * 0.06,
                  vertical: _screenHeight * 0.03,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                        child: Text(
                          'Create Merchant Account',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Constants.mainColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: _screenHeight * 0.01),
                    Form(
                      child: Column(
                        children: [
                          nameField(
                            'Username',
                            'Enter username',
                            CupertinoIcons.person_crop_circle_badge_checkmark,
                            userNameController,
                            TextInputType.text,
                          ),
                          SizedBox(height: _screenHeight * 0.019),
                          nameField(
                              'Account Number',
                              'Enter account number',
                              Icons.account_box,
                              accountController,
                              TextInputType.number),
                          SizedBox(height: _screenHeight * 0.019),
                          nameField('TIN', 'Enter TIN', Icons.recent_actors,
                              tinController, TextInputType.number),
                          SizedBox(height: _screenHeight * 0.019),
                          nameField(
                            'City / State',
                            'Enter City',
                            Icons.location_city_outlined,
                            cityController,
                            TextInputType.text,
                          ),
                          SizedBox(height: _screenHeight * 0.019),
                          passwordField(),
                          SizedBox(height: _screenHeight * 0.04),
                          submitButton(context),
                          SizedBox(height: _screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account?  ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginScreen(),
                                  ),
                                ),
                                child: Text(
                                  "Login.",
                                  style: TextStyle(
                                    color: Constants.mainColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nameField(
      String name, String example, icon, controller, TextInputType type) {
    // TextEditingController inputController;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '  $name',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13.5,
            ),
          ),
        ),
        SizedBox(
          height: _screenHeight * 0.007,
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 18.0, right: 6.0, top: 1.0, bottom: 1.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: TextField(
            textCapitalization: TextCapitalization.characters,
            controller: controller,
            keyboardType: type,
            style: kInputLabelStyle,
            onChanged: (value) {
              setState(() {
                memberId = controller.text;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: example,
              hintStyle: TextStyle(color: Colors.grey[400]),
              errorText: validateId(),
              suffixIcon: icon != null
                  ? Icon(icon, size: 20.0)
                  : const Icon(Icons.person, size: 20.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '  Password',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 6.0, top: 1.0, bottom: 1.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: TextField(
            obscureText: hidePassword,
            keyboardType: TextInputType.emailAddress,
            controller: passwordController,
            onChanged: (value) {
              if (value != '') {
                setState(() {
                  passwordActive = true;
                  password = passwordController.text;
                });
              } else {
                passwordActive = false;
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey[400]),
              errorText: validatePassword(),
              suffixIcon: passwordActive
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      child: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                        size: 20.0,
                      ),
                    )
                  : const Icon(
                      Icons.lock,
                      size: 20.0,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(context) {
    final def = Provider.of<Globals>(context);
    return Container(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      width: _screenWidth,
      decoration: BoxDecoration(
        // color: Colors.amber,
        color: Constants.mainColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: def.getLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : FlatButton(
              onPressed: () async {
                print('trying to login');
                if (userNameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  AuthController.createMerchant(
                    context,
                    {
                      "channel_code": "APISNG",
                      "customer_tier": "2",
                      "reference": "NXG34567898FGHJJB8",
                      "account_no": accountController.text,
                      "director_bvn": "22334744900",
                      "tin": tinController.text,
                      "user_name": userNameController.text,
                      "city": cityController.text,
                      "state": cityController.text,
                      "wallet_category": "parent",
                      "password": passwordController.text
                    },
                  );
                } else {
                  print('invalid data');
                }
              },
              child: const Text(
                'Create Merchant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}
