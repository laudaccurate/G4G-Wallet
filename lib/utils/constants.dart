// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

class Constants {
  static const appName = "G4G Wallet";
  static const logoImage = "assets/images/logo.png";

  //UI constants

  static Color mainColor = Color(0xffCBB26A);
  static Color mainColorLight = Color(0xffCBB26A).withOpacity(0.3);
  static Color secondaryColor = Colors.black.withOpacity(0.65);
  static Color labelColor = Colors.grey.shade500;
  static Color deepMainColor = Color(0xffea2237);
  static int kPinLength = 4;
  static String kBackgroundImage = "assets/images/bk2.jpg";
  static String noDataFound = "assets/images/no_file.svg";
  static String apiError = "assets/images/errors.svg";
  static String bankName = "G4G Wallet";
  static String bankCode = "004";
  static String version = "1.0.1";
  static String currency = "SLL";
  static SizedBox spacer = SizedBox(height: 20);

  //Urls
  //
  // static String url = "http://192.168.1.225:9096/ibank/api/v1.0/";
  // static String url = "http://192.168.1.225:9096/";
  // static String url = "http://192.168.1.95:9096/ibank/api/v1.0/";
  // static String url = "http://10.93.101.144:9096/ibank/api/v1.0/";
  // static String url = "http://41.78.85.63:9096/ibank/api/v1.0/";
  // static String url = "http://10.93.101.144:9096/";
  //usg public url
  // static String url = "http://197.251.247.203:9096/";
  // static String url = "https://union.ngrok.io/ibank/api/v1.0/";
  static String url = "http://192.168.1.225:8680/ibank/api/v1.0/";

  // static String url = "http://192.168.1.95:9096/ibank/api/v1.0/";
  // static String documentUrl = "http://10.93.101.144:9096/";
  static String documentUrl = "http://197.251.247.203:8680/";
  // static String documentUrl = "http://41.78.85.63:9096/";
  // static String url = "http://192.168.1.225:8680/ibank/api/v1.0/";
  static final dynamic header = {
    "content-Type": "application/json",
  };

  static final dynamic apiHeaders = {
    "x-api-key": "1234",
    "x-api-secret": "1234",
    "x-api-source": "1234",
    "x-api-token": "1234",
  };

  static final dynamic header2 = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  static const double dialogPadding = 20;
  static const double dialogAvatarRadius = 45;
}

Map<String, dynamic> networkInfo = {};
// List<PaymentDatum> paymentType = [];
// BranchModel savedBranches =
//     BranchModel(data: [], message: '', responseCode: '');
// TransferBeneModel beneficiaries =
//     TransferBeneModel(data: [], message: '', responseCode: '');
