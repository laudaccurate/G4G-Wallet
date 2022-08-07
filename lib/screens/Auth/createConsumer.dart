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

class CreateConsumerScreen extends StatefulWidget {
  final String memberId;

  const CreateConsumerScreen({Key key, this.memberId}) : super(key: key);
  @override
  _CreateConsumerScreenState createState() => _CreateConsumerScreenState();
}

class _CreateConsumerScreenState extends State<CreateConsumerScreen> {
  bool passwordActive = false;
  bool hidePassword = true;
  final login = GlobalKey<ScaffoldState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController tinController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  double _screenHeight;
  double _screenWidth;

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
                          'Create User Account',
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
                          nameField('NIN', 'Enter NIN', Icons.recent_actors,
                              tinController, TextInputType.number),
                          SizedBox(height: _screenHeight * 0.019),
                          nameField(
                            'BVN',
                            'Enter BVN',
                            Icons.password_rounded,
                            bvnController,
                            TextInputType.text,
                          ),
                          SizedBox(height: _screenHeight * 0.019),
                          nameField(
                            'Reference Number',
                            'Enter reference number',
                            Icons.numbers_rounded,
                            referenceController,
                            TextInputType.text,
                          ),
                          SizedBox(height: _screenHeight * 0.019),
                          passwordField(passwordController, 'Password'),
                          SizedBox(height: _screenHeight * 0.019),
                          passwordField(passwordController, 'Confirm Password'),
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
                          SizedBox(height: _screenHeight * 0.06),
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
            decoration: InputDecoration(
              labelStyle: kInputLabelStyle,
              border: InputBorder.none,
              hintText: example,
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: icon != null
                  ? Icon(icon, size: 20.0)
                  : const Icon(Icons.person, size: 20.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordField(TextEditingController controller, String label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '  $label',
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
            controller: controller,
            onChanged: (value) {
              if (value != '') {
                setState(() {
                  passwordActive = true;
                });
              } else {
                passwordActive = false;
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
              hintStyle: TextStyle(color: Colors.grey[400]),
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
                  AuthController.createConsumer(
                    context,
                    {
                      "channel_code": "APISNG",
                      "customer_tier": "2",
                      "reference": referenceController.text,
                      "account_no": accountController.text,
                      "bvn": bvnController.text,
                      "password": passwordController.text,
                      "nin": tinController.text
                    },
                  );
                } else {
                  print('invalid data');
                }
              },
              child: const Text(
                'Create Account',
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
