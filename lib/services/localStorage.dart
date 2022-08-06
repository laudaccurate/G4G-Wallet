// @dart=2.9
// ignore_for_file: unnecessary_null_comparison, prefer_conditional_assignment, constant_identifier_names, file_names

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  //KEYS
  static const String HasAgreedToTNC = 'agreeTNC';
  static const String DarkModeKey = 'darkmode';
  static const String LoggedInKey = 'isLoggedIn';
  static const String UserSessionTimedOutKey = 'userSessionTimedOut';
  static const String UsernameKey = 'username';
  static const String ProfilePicKey = 'profilePic';
  static const String FastBalance = 'fastBalance';
  static const String BioActivated = 'bioLogin';
  static const String DefaultQRAccount = 'defaultAccount';
  static const String UUID = 'uuid';
  static const String AppBackground = 'backgroundImage';
  static const String AppBackgroundChanged = 'backgroundImageChanged';

  bool get agreeTNC => _getFromDisk(HasAgreedToTNC) ?? false;
  set agreeTNC(bool value) => _saveToDisk(HasAgreedToTNC, value);

  bool get darkMode => _getFromDisk(DarkModeKey) ?? false;
  set darkMode(bool value) => _saveToDisk(DarkModeKey, value);

  bool get isLoggedIn => _getFromDisk(LoggedInKey) ?? false;
  set isLoggedIn(bool value) => _saveToDisk(LoggedInKey, value);

  bool get fastBalance => _getFromDisk(FastBalance) ?? false;
  set fastBalance(bool value) => _saveToDisk(FastBalance, value);

  bool get bioLogin => _getFromDisk(BioActivated) ?? false;
  set bioLogin(bool value) => _saveToDisk(BioActivated, value);

  bool get backgroundChanged => _getFromDisk(AppBackgroundChanged) ?? false;
  set backgroundChanged(bool value) => _saveToDisk(AppBackgroundChanged, value);

  bool get userSessionTimedOut => _getFromDisk(UserSessionTimedOutKey) ?? false;
  set userSessionTimedOut(bool value) =>
      _saveToDisk(UserSessionTimedOutKey, value);

  String get username => _getFromDisk(UsernameKey) ?? '';
  set username(String value) => _saveToDisk(UsernameKey, value);

  String get backgroundImage =>
      _getFromDisk(AppBackground) ?? "assets/images/bk2.jpg";
  set backgroundImage(String value) => _saveToDisk(AppBackground, value);

  String get uuid => _getFromDisk(UUID) ?? '';
  set uuid(String value) => _saveToDisk(UUID, value);

  String get defaultAccount => _getFromDisk(DefaultQRAccount) ?? '';
  set defaultAccount(String value) => _saveToDisk(DefaultQRAccount, value);

  String get profilePic => _getFromDisk(ProfilePicKey) ?? '';
  set profilePic(String value) => _saveToDisk(ProfilePicKey, value);

  void _saveToDisk<T>(String key, T content) {
    //print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    //print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
}
