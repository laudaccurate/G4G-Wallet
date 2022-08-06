// @dart=2.9

// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void showErrorMessage(BuildContext context, String message) {
  //print("Vibrate");
  //print("__________________________________");
  showFlash(
      context: context,
      duration: Duration(seconds: 15),
      // persistent: false,
      builder: (_, controller) {
        return Flash(
          backgroundColor: Constants.labelColor,
          controller: controller,
          position: FlashPosition.top,
          behavior: FlashBehavior.fixed,
          child: FlashBar(
            // showProgressIndicator: true,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: Text('DISMISS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            icon: Icon(
              Icons.error,
              size: 36.0,
              color: Colors.white,
            ),
            title: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: null,
          ),
        );
      });
}

void showConfirmationMessage(BuildContext context, String message,
    Function function, FlashController<dynamic> cont) {
  showFlash(
      context: context,
      duration: Duration(seconds: 20),
      builder: (_, cont) {
        return Flash(
          backgroundColor: Colors.blueAccent.withOpacity(0.8),
          controller: cont,
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          child: FlashBar(
            icon: Icon(
              Icons.error,
              size: 36.0,
              color: Colors.white,
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () => cont.dismiss()),
              TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    //print("yesss");
                    cont.dismiss();
                    function();
                  }),
            ],
          ),
        );
      });
}

showNetworkMessage(BuildContext context, String message) {
  HapticFeedback.lightImpact();
  return showFlash(
      context: context,
      duration: Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          backgroundColor: Colors.blue,
          controller: controller,
          position: FlashPosition.top,
          behavior: FlashBehavior.fixed,
          child: FlashBar(
            icon: Icon(
              Icons.error,
              size: 36.0,
              color: Colors.white,
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      });
}
