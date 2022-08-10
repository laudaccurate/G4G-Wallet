// @dart=2.9

// ignore_for_file: file_names

import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/models.dart/loginModel.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class AuthAPI {
// LOGIN
  static Future login(
    Map<String, dynamic> details,
  ) async {
    //print("API called");
    String url = "${Constants.url}/CAMLLogin";

    print("LOGGING IN");
    details.forEach((key, value) => print("$key = $value"));
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(details),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result["response_code"] == "00") {
        var res = jsonDecode(response.body);
        log(response.body);
        //print("____user");
        //print(responds.data.accountsList[0].localEquivalentAvailableBalance);
        //print(responds.data.accountsList[0].accountNumber);
        return res;
      } else {
        throw PlatformException(
          code: result["response_code"].toString(),
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }

  static Future<LoginModel> getBalance(Map<String, dynamic> details,
      {String bio}) async {
    //print("API called");
    String url = "${Constants.url}/GetBalance";

    print(url);

    details.forEach((key, value) => print("$key = $value"));
    final response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode({
        {
          "user_email": "test_user+access@bitt.com",
          "user_token":
              "eyJhbGciOiJSUI1NiIsInR5cCI6IkpXVCJ9.eyJhbGlhcyI6IkB0YWNoLjAxZiIsImV4cGlyeSI6IjIwMjEtMDktMjdUMTM6MjU6NDMuMDg2NDMxWiIsImlzcyI6ImdvbmRvciBjb21tZXJjZSIsIm9yZyI6ImNmYiIsInRva2VuX3R5cGUiOiJhY2Nlc3MiLCJ1c2VyaWQiOiIwMUZFUERXS1BHVjkxVzRCRE45MTczTjBWRyJ9.zMIxdoqkxY3MFnY7zRUeQdA88SrXD-KcukT2fePc3a4IMhtuAuBcNjSnVQ9J4AUNAz2BQGnhvjsJiOJGcV4M6w1n1tFJMr6xnDTChb2OZa2eSi6u3qjppOKXgQ_t0EOPpTC9Iqx3zgRt0C6Nl1z14ixmGmaAY0SKKgjHSI1ieiuRtzJuJi7qq7nHf_u4iypr4mMN1H6KCrIq86xEPp2bN2H3cEHQr2AaSjLamoPkT_oA0RHoNroZvTqmpZE80hvYHBSECUagiAazlb_ANMJgNF0zo_uSSMkyXHpASwqdaZnPLgINzLkIJrfNLwDf4P1VEh9VoaB1E9ElQanZVBrN51VDhBitTzGolSxk0_P37aVPrS9yeWceJTHs1GojMOGCosYRu_wi05n0bsG_iAEFRFxlV3pT-2YdS5YAbUdEJj65NO-6SkmPQBcMGCwHCztDn6h6lQZiUPgjnTqsSUq_kUC_X3ki4I7fVohm-Z9jplLOPHHk88CmlJnUI0AgYYfJQw8Kwi5010-1eTz6EFVI7_fjeV_OPI-emxJ4F1QaUy934XC69kWPDgfeLtBfYmee3M3N6MaD6eurltD23YknDhg-VWcBD_BycmUKMIQ5hXHL-0ix_e97zr1kw7UjcwdNwlCC6m9AkrEhevzvG4nQ3ZIVRhb_fklXykYITjulUmQ",
          "user_type": "USER",
          "channel_code": "APISNG"
        }
      }),
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
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }

  static Future<LoginModel> createConsumer(Map<String, dynamic> details) async {
    //print("API called");
    String url = "${Constants.url}/CreateConsumer";

    print(url);

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
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }

  static Future<LoginModel> createMerchant(Map<String, dynamic> details) async {
    //print("API called");
    String url = "${Constants.url}/CreateMerchant";

    print(url);

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
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }

  static Future<LoginModel> payFromWallet(Map<String, dynamic> details,
      {String bio}) async {
    //print("API called");
    String url = "${Constants.url}/PaymentFromWallet";

    print(url);

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
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }

  static Future<LoginModel> payWithPin(Map<String, dynamic> details,
      {String bio}) async {
    //print("API called");
    String url = "${Constants.url}/PayWithTransactionPin";

    print(url);

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
          message: result["response_message"],
        );
      }
      // return responds;
    } else {
      // return null;
      //print(response.statusCode);
      throw PlatformException(
        code: response.statusCode.toString(),
        message:
            "${jsonDecode(response.body)['httpMessage']} - ${jsonDecode(response.body)['moreInformation']}",
      );
    }
  }
}
