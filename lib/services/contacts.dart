import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactsPicker {
  Future<bool> _checkPermission() async {
    return await FlutterContactPicker.hasPermission();
  }

  Future<bool> _requestPermissions() async {
    var permission = await _checkPermission();
    if (permission) {
      return permission;
    } else {
      final granted = await FlutterContactPicker.requestPermission();
      return granted;
    }
  }

  fetchContact() async {
    bool hasPermission = await _requestPermissions();
    if (hasPermission) {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      if (contact != null) {
        return contact;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
