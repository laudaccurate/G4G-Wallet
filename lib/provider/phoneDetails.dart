// ignore_for_file: prefer_final_fields, file_names

import 'package:flutter/material.dart';

class PhoneInfo with ChangeNotifier {
  String _deviceId = "";
  String _deviceIp = "";
  String _model = "";
  String _manufacturer = "";
  String _brand = "";
  String _country = "";
  double _latitude = 0;
  double _longitute = 0;
  String _deviceOs = "";
  String _fbcmToken = "";
  String _appVersion = "1.0";
  String _entrySource = "M";
  String get getdeviceId => _deviceId;
  double get getLat => _latitude;
  double get getLng => _longitute;
  String get getEntrySource => _entrySource;
  String get getdeviceIp => _deviceIp;
  String get getmodel => _model;
  String get getManufacturer => _manufacturer;
  String get getbrand => _brand;
  String get getcountry => _country;
  String get getdeviceOs => _deviceOs;
  String get getfbcmToken => _fbcmToken;
  String get getappVersion => _appVersion;
  setdeviceID(String id) {
    _deviceId = id;
    notifyListeners();
  }

  setLat(double id) {
    _latitude = id;
    notifyListeners();
  }

  setLng(double id) {
    _longitute = id;
    notifyListeners();
  }

  setdeviceIp(String ip) {
    _deviceIp = ip;
    notifyListeners();
  }

  setmodel(String id) {
    _model = id;
    notifyListeners();
  }

  setmanufacturer(String id) {
    _manufacturer = id;
    notifyListeners();
  }

  setbrand(String id) {
    _brand = id;
    notifyListeners();
  }

  setFCMToken(String id) {
    _fbcmToken = id;
    notifyListeners();
  }

  setcountry(String id) {
    _country = id;
    notifyListeners();
  }

  setdeviceOs(String id) {
    _deviceOs = id;
    notifyListeners();
  }

  notifyListeners();
}
