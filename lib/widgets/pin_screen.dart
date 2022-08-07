// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/widgets/logo_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? email;
  final TextEditingController pinController;
  final VoidCallback onSubmit;
  final bool isOtpVerification;

  // ignore: use_key_in_widget_constructors
  const PinCodeVerificationScreen(
      {this.phoneNumber,
      this.email,
      required this.pinController,
      required this.onSubmit,
      this.isOtpVerification = false});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  // TextEditingController pinController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  int _counter = 30;

  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void initState() {
    if (mounted) {
      _startTimer();
    }
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final Globals globals = Provider.of<Globals>(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  // const SizedBox(height: 30),
                  Container(
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Lottie.asset('assets/json/otp2.json'),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Transaction Verification',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  widget.isOtpVerification
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8),
                          child: RichText(
                            text: TextSpan(
                                text: "Enter the code sent to ",
                                children: [
                                  TextSpan(
                                      text: "${widget.phoneNumber}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                ],
                                style: const TextStyle(fontSize: 15)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,

                          // pastedTextStyle: TextStyle(
                          //   color: Colors.green.shade600,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          length: 4,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.slide,
                          validator: (v) {
                            if (v!.length < 3) {
                              return "PIN must be 4 digits";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.transparent,
                            inactiveFillColor: Colors.transparent,
                            selectedFillColor: Colors.transparent,
                          ),
                          cursorColor: themeProvider.themeMode().textColor,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: widget.pinController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {},
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.isOtpVerification)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        if (_counter < 1) ...[
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _counter += 30;
                                  _counter *= 2;
                                });

                                _startTimer();
                                // AuthController.resendOTP(
                                //     context, {'email': widget.email, "type": "I"});
                              },
                              child: const Text(
                                "RESEND",
                                style: TextStyle(
                                    color: Color(0xFF91D3B3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ))
                        ] else ...[
                          Text(
                            _counter.toString(),
                            style: const TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ]
                      ],
                    ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      color: Colors.greenAccent,
                      child: Container(
                        child: ButtonTheme(
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              formKey.currentState!.validate();
                              widget.onSubmit();
                            },
                            child: Center(
                                child: Text(
                              "VERIFY".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: widget.pinController.text.length == 4
                                ? Colors.green
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const []),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (globals.getLoading) ...[
            Container(
              decoration:
                  BoxDecoration(color: Constants.mainColor.withOpacity(0.9)),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: LogoLoader(),
              ),
            )
          ]
        ],
      ),
    ));
  }
}
