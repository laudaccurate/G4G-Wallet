// @dart=2.9

// ignore_for_file: file_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/models.dart/loginModel.dart';
import 'package:gfg_wallet/provider/phoneDetails.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:provider/provider.dart';

class AuthAPI {
// LOGIN
  static Future<LoginModel> login(Map<String, dynamic> details,
      {String bio}) async {
    //print("API called");
    String url;
    if (bio == null) {
      url = "${Constants.url}user/login";
    } else {
      url = "${Constants.url}user/biologin";
    }

    print(url);

    print("LOGGING IN");
    details.forEach((key, value) => print("$key = $value"));
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    print("======");
    print(response.body);
    print("======");

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["responseCode"] == "000") {
        LoginModel responds = LoginModel.fromJson(json.decode(response.body));
        log(response.body);
        //print("____user");
        //print(responds.data.accountsList[0].localEquivalentAvailableBalance);
        //print(responds.data.accountsList[0].accountNumber);
        return responds;
      } else {
        throw PlatformException(
          code: result["responseCode"].toString(),
          message: result["message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message: "Error connecting to server",
      );
    }
  }

// FIRST TIME LOGIN
  static Future<String> passwordSetup(details) async {
    //print("API called");
    final url = "${Constants.url}user/initialPasswordSetup";
    print(url);

    //print(details);
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    print("======");
    print(response.body);
    print("======");

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["responseCode"] == "000") {
        return result["message"].toString();
      } else {
        throw PlatformException(
          code: result["responseCode"].toString(),
          message: result["message"].toString(),
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message: "Error connecting to server",
      );
    }
  }

// FIRST TIME LOGIN
  static Future<dynamic> validateKYC(custNo) async {
    // final url = "${Constants.url}user/validateKyc/000146";
    final url = "${Constants.url}user/validateKyc/$custNo";
    //print(url);

    final response = await http.get(
      Uri.parse(url),
      headers: Constants.header,
    );

    //print("======");
    //print(response.body);
    //print("======");

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["responseCode"] == "000") {
        return result["data"];
      } else if (result["responseCode"] == "999") {
        return result["data"];
      } else {
        throw PlatformException(
          code: result["responseCode"].toString(),
          message: result["message"].toString(),
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message: "Error connecting to server",
      );
    }
  }

  static Future<bool> pinSetup(details) async {
    //print("API called");
    final url = "${Constants.url}user/pinSetup";
    //print(url);

    //print(details);
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    //print("======");
    //print(response.body);
    //print("======");

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["responseCode"] == "000") {
        return true;
      } else {
        throw PlatformException(
          code: result["responseCode"].toString(),
          message: result["message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

// SELF ENROLL

  static Future<String> instantRegistration(
      BuildContext context, String customerNumber) async {
    final deviceInfo = Provider.of<PhoneInfo>(context, listen: false);
    //print("API called");
    final url = "${Constants.url}user/instantRegistration";
    //print(url);

    Map<String, dynamic> body = {
      "appVersion": deviceInfo.getappVersion,
      "country": deviceInfo.getcountry,
      "customerNumber": customerNumber,
      "deviceBrand": deviceInfo.getbrand,
      "deviceId": deviceInfo.getdeviceId,
      "deviceIp": deviceInfo.getdeviceIp,
      "deviceManufacturer": deviceInfo.getManufacturer,
      "deviceModel": deviceInfo.getmodel,
      "deviceOs": deviceInfo.getdeviceOs
    };

    //print(jsonEncode(body));
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(body),
    );

    //print("======");
    //print(response.body);
    //print("======");

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["responseCode"] == "000") {
        return result["message"];
      } else {
        throw PlatformException(
          code: result["responseCode"].toString(),
          message: result["message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<Map<String, dynamic>> validateCustomer(details) async {
    // details.forEach((key, value) => //print('$key: $value'));

    //print("API called");
    //print(details);
    final url = "${Constants.url}user/validateCustomer";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    //print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result["responseCode"] == '000') {
        return result["data"];
      } else {
        throw PlatformException(
          code: 'CUST_VALIDATION_ERROR',
          message: result['message'],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<String> confirmCustomerDetails(
      Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/confirmCustomer";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    //print(response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result['responseCode'] == '000') {
        return result['message'];
      } else {
        throw PlatformException(
          code: 'CUSTOMER_CONFIRMATION_ERROR',
          message: result['message'],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<String> registerCustomer(Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/registerCustomer";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    //print(response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result['responseCode'] == '000') {
        return result['message'];
      } else {
        throw PlatformException(
          code: 'CUSTOMER_REGISTRATION_ERROR',
          message: result['message'],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  // SETTINGS
  static Future<String> changePassword(Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/changePassword";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    if (response.statusCode == 200) {
      //print(response.body.toString());

      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result["responseCode"] == '000') {
        //print('PASSWORD CHANGE SUCCESS');
        return result["message"];
      } else {
        //print('not done');
        throw PlatformException(
          code: 'PASSWORD_CHANGE_ERROR',
          message: result["message"],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<String> changePin(Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/changePin";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    if (response.statusCode == 200) {
      //print(response.body.toString());

      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result["responseCode"] == '000') {
        //print('PIN CHANGE SUCCESS');
        return result["message"];
      } else {
        //print('not done');
        throw PlatformException(
          code: 'PIN_CHANGE_ERROR',
          message: result["message"],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<String> forgotPin(Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/forgotPin";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    if (response.statusCode == 200) {
      //print(response.body.toString());

      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result["responseCode"] == '000') {
        //print('PIN RESET SUCCESS');
        return result["message"];
      } else {
        //print('not done');
        throw PlatformException(
          code: 'PIN_RESET_ERROR',
          message: result["message"],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }

  static Future<String> forgotPassword(Map<String, String> details) async {
    //print("API called");
    final url = "${Constants.url}user/forgotPassword";
    //print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    if (response.statusCode == 200) {
      //print(response.body.toString());

      Map<String, dynamic> result = json.decode(response.body.toString());
      if (result["responseCode"] == '000') {
        //print('PASSWORD RESET SUCCESS');
        return result["message"];
      } else {
        //print('not done');
        throw PlatformException(
          code: 'PASSWORD_RESET_ERROR',
          message: result["message"],
        );
      }
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: 'An error occurred. Please try again',
      );
    }
  }
}
