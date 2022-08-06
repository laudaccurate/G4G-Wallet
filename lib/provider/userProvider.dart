// @dart=2.9

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../models.dart/accountModels.dart';
import '../models.dart/loginModel.dart';

class UserProvider with ChangeNotifier {
  UserData _user;
  List<AccountModelDatum> _accountsList;
  UserData get getUser => _user;
  List<AccountModelDatum> get getAccountList => _accountsList;
  setAccount(List<AccountModelDatum> data) {
    _accountsList = data;
    notifyListeners();
  }

  setUser(UserData id) {
    _user = id;
    notifyListeners();
  }
}
