// @dart=2.9

import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

// Future<bool> authenticate() async {
//   final _auth = LocalAuthentication();
//   return _auth;
// }

Future<bool> checkBiometrics() async {
  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics;
  try {
    canCheckBiometrics = await auth.canCheckBiometrics;
    return canCheckBiometrics;
  } on PlatformException catch (e) {
    // print(e);
  }
  return canCheckBiometrics;
}

Future<bool> authenticate() async {
  // bool authenticated = false;
  final auth = LocalAuthentication();

  try {
    // setState(() {
    //   _isAuthenticating = true;
    //   _authorized = 'Authenticating';
    // });

    return await auth.authenticate(
      biometricOnly: true,
      localizedReason: 'Scan your fingerprint to authenticate',
      useErrorDialogs: true,
      stickyAuth: true);
  } on PlatformException catch (e) {
    //print(e);
    return false;
  }

  // if (!mounted) return;
}
