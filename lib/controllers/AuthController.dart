// @dart=2.9

// ignore_for_file: file_names, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/apis/authAPI.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/screens/landing_page.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/errorWidget.dart';
import 'package:gfg_wallet/utils/internet_check.dart';
import 'package:provider/provider.dart';

import '../provider/globals.dart';

class AuthController {
  static login(
    BuildContext context,
    details,
    String bio,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      LocalStorageService storageService = locator<LocalStorageService>();
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.login(details, bio: bio);

        user.setUser(res.data);

        if (res.data.customerType == "I") {
          // await AccountController.getAccounts(context: context);
          // var expenses = await UtilitiesAPI.getExpenses();
          // def.setExpenseTypes(expenses);

          def.setProfilePic(storageService.profilePic);

          if (res.data.firstTimeLogin) {
            storageService.username = "";
          } else if (res.data.changePassword) {
            storageService.username = details["userId"];
          } else if (res.data.setPin) {
            storageService.username = details["userId"];
          } else {
            storageService.username = details["userId"];
            storageService.isLoggedIn = true;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
              (route) => false,
            );
          }
        } else {
          showNetworkMessage(context,
              "Corporate accounts are not allowed to use this platform");
        }

        // _user.setAccount(data.data);

      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message ?? "An Error Occured");
    } on SocketException catch (_) {
      showErrorMessage(context, "Error connecting to service");
    } finally {
      def.setLoading(false);
    }
  }

  static initialPasswordSetup(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.passwordSetup(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
        return null;
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
      return null;
    } finally {
      def.setLoading(false);
    }
  }

  static pinSetup(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    // final _user = Provider.of<UserProvider>(context, listen: false);
    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        await AuthAPI.pinSetup(details);
      } else {
        showNetworkMessage(context, "Please check your internet");
        return null;
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
      return null;
    } finally {
      def.setLoading(false);
    }
  }

  static instantRegistration(
    BuildContext context,
    String customerNumber,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    // final _user = Provider.of<UserProvider>(context, listen: false);
    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.instantRegistration(context, customerNumber);

        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
        return null;
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
      return null;
    } finally {
      def.setLoading(false);
    }
  }

  static validateCustomer(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.validateCustomer(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static confirmCustDetails(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.confirmCustomerDetails(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static registerCustomer(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.registerCustomer(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static changePin(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        String res = await AuthAPI.changePin(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static changePassword(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.changePassword(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static forgotPin(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.forgotPin(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
    } finally {
      def.setLoading(false);
    }
  }

  static forgotPassword(
    BuildContext context,
    details,
    GlobalKey<ScaffoldState> key,
  ) async {
    final def = Provider.of<Globals>(context, listen: false);

    try {
      bool checkinternet = await internetCheck();
      def.setLoading(true);
      if (checkinternet) {
        var res = await AuthAPI.forgotPassword(details);
        return res;
      } else {
        showNetworkMessage(context, "Please check your internet");
        return null;
      }
    } on PlatformException catch (e) {
      showErrorMessage(context, e.message);
      return null;
    } finally {
      def.setLoading(false);
    }
  }
}
