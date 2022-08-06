// @dart=2.9
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalServices {
  Future<bool> askPermissions() async {
    PermissionStatus permissionStatus;
    while (permissionStatus != PermissionStatus.granted) {
      try {
        permissionStatus = await getContactPermission();

        if (permissionStatus != PermissionStatus.granted) {
          handleInvalidPermissions(permissionStatus);
        } else {}
      } catch (e) {
        await openAppSettings();
        // return permissionStatus.isGranted;
      }
    }
    return permissionStatus.isGranted;
  }

  Future<PermissionStatus> getContactPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result ?? PermissionStatus.limited;
    } else {
      return status;
    }
  }

  void handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Access to location data denied',
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: 'PERMISSION_DISABLED',
          message: 'Location data is not available on device',
          details: null);
    }
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  sendMail(String mailTo) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailTo,
      query:
          encodeQueryParameters(<String, String>{'subject': 'Leave a message'}),
    );

    launch(emailLaunchUri.toString());
  }

  Future<void> makePhoneCall(String number) async {
    String url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> pickContact() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    //print("contact = ${contact.phoneNumber.label}");
    return contact.phoneNumber.number
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(' ', '')
        .replaceAll(')', '');
  }
}
