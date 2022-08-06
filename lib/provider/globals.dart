// @dart=2.9

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../models.dart/loginModel.dart';
import '../models.dart/paymentTypeModel.dart';

class Globals with ChangeNotifier {
  bool _isDrawerOpen = false;
  Menu _menu;
  Map<String, dynamic> _secQuestion = {};
  Menu get getMenu => _menu;
  String _title = "";
  List<dynamic> _expenseTypes = [];
  List<PaymentDatum> paymentTypes = [];
  bool _isLoading = false;
  bool _hasInternet = false;
  bool _bkChanged = false;
  String _widgetCode = "";
  String _loaderMessage = "loading...";
  double _ihave = 0.0;
  // String _appBackgroundImage = "assets/images/bk2.jpg";
  String _appBackgroundImage = "assets/images/pexel_14.jpg";
  // String _appBackgroundImage = "assets/images/pexel_1.jpg";
  String _profilePic;
  dynamic _value;

  String get getProfilePic => _profilePic;
  String get getAppBackground => _appBackgroundImage;
  bool get getIsDrawerOpen => _isDrawerOpen;
  String get getWidgetCode => _widgetCode;
  String get getTitle => _title;
  String get getLoaderMessage => _loaderMessage;
  Map<String, dynamic> get getSecQuestion => _secQuestion;
  bool get getLoading => _isLoading;
  bool get getInternet => _hasInternet;
  bool get getBkChanged => _bkChanged;
  dynamic get getValue => _value;
  double get getIhave => _ihave;
  List<dynamic> get getExpenseTypes => _expenseTypes;

  setIsDrawerOpen(bool load) {
    _isDrawerOpen = load;
    notifyListeners();
  }

  setLoaderMessage(String load) {
    _loaderMessage = load;
    notifyListeners();
  }

  setSecQuestion(Map<String, dynamic> load) {
    _secQuestion = load;
    notifyListeners();
  }

  setIHave(double load) {
    _ihave = load;
    notifyListeners();
  }

  setInternet(bool load) {
    //print("____ setting internet");
    _hasInternet = load;
    notifyListeners();
  }

  setExpenseTypes(List<dynamic> load) {
    _expenseTypes = load;
    notifyListeners();
  }

  setLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  setBkChanged(bool load) {
    _bkChanged = load;
    notifyListeners();
  }

  setMenu(Menu menu) {
    _menu = menu;
    notifyListeners();
  }

  setWidgetCode(String data, dynamic values) {
    _widgetCode = data;
    _value = values;
    notifyListeners();
  }

  setTitle(String data) {
    _title = data;
    // notifyListeners();
  }

  setProfilePic(String data) {
    //print("setting profile pic");
    _profilePic = data;
    // notifyListeners();
  }

  setAppBackground(String background) {
    _appBackgroundImage = background;
    notifyListeners();
  }
}
