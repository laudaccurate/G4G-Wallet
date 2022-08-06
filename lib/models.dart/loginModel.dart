// @dart=2.9

// ignore_for_file: file_names

import 'dart:convert';

import 'accountModels.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.responseCode,
    this.message,
    this.data,
  });

  String responseCode;
  String message;
  UserData data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        responseCode: json["responseCode"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  UserData({
    this.userId,
    this.userAlias,
    this.updateFlag,
    this.setPin,
    this.changePassword,
    this.firstTimeLogin,
    this.email,
    this.userToken,
    this.customerNumber,
    this.updateUrl,
    this.lastLogin,
    this.secQuestionsList,
    this.accountsList,
    this.loansList,
    this.menus,
    this.customerType,
    this.customerPhone,
    this.customerAddress,
  });

  String userId;
  String userAlias;
  bool updateFlag;
  bool setPin;
  bool changePassword;
  String email;
  String userToken;
  String customerNumber;
  bool firstTimeLogin;
  String updateUrl;
  String lastLogin;
  List<SecQuestionsList> secQuestionsList;
  List<AccountModelDatum> accountsList;
  List<LoansList> loansList;
  List<Menu> menus;
  String customerType;
  String customerPhone;
  String customerAddress;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        userAlias: json["userAlias"],
        updateFlag: json["updateFlag"],
        setPin: json["setPin"],
        changePassword: json["changePassword"],
        firstTimeLogin: json["firstTimeLogin"],
        email: json["email"],
        userToken: json["userToken"],
        customerNumber: json["customerNumber"],
        updateUrl: json["updateUrl"],
        lastLogin: json["lastLogin"],
        secQuestionsList: List<SecQuestionsList>.from(
            json["secQuestionsList"].map((x) => SecQuestionsList.fromJson(x))),
        accountsList: List<AccountModelDatum>.from(
            json["accountsList"].map((x) => AccountModelDatum.fromJson(x))),
        loansList: List<LoansList>.from(
            json["loansList"].map((x) => LoansList.fromJson(x))),
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        customerType: json["customerType"],
        customerPhone: json["customerPhone"],
        customerAddress: json["customerAddress"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userAlias": userAlias,
        "updateFlag": updateFlag,
        "setPin": setPin,
        "changePassword": changePassword,
        "firstTimeLogin": firstTimeLogin,
        "email": email,
        "userToken": userToken,
        "customerNumber": customerNumber,
        "updateUrl": updateUrl,
        "lastLogin": lastLogin,
        "secQuestionsList":
            List<dynamic>.from(secQuestionsList.map((x) => x.toJson())),
        "accountsList": List<dynamic>.from(accountsList.map((x) => x.toJson())),
        "loansList": List<dynamic>.from(loansList.map((x) => x.toJson())),
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
        "customerType": customerType,
        "customerPhone": customerPhone,
        "customerAddress": customerAddress,
      };
}

/*
class AccountsList {
  AccountsList({
    this.custnum,
    this.acctLink,
    this.acctdescrp,
    this.avbal,
    this.lgbal,
    this.curr,
    this.actype,
    this.localeqvAvbal,
    this.accountMandate,
  });

  String custnum;
  String acctLink;
  String acctdescrp;
  String avbal;
  String lgbal;
  String curr;
  String actype;
  String localeqvAvbal;
  dynamic accountMandate;

  factory AccountsList.fromJson(Map<String, dynamic> json) => AccountsList(
        custnum: json["CUSTNUM"],
        acctLink: json["ACCT_LINK"],
        acctdescrp: json["ACCTDESCRP"],
        avbal: json["AVBAL"],
        lgbal: json["LGBAL"],
        curr: json["CURR"],
        actype: json["ACTYPE"],
        localeqvAvbal: json["LOCALEQV_AVBAL"],
        accountMandate: json["ACCOUNT_MANDATE"],
      );

  Map<String, dynamic> toJson() => {
        "CUSTNUM": custnum,
        "ACCT_LINK": acctLink,
        "ACCTDESCRP": acctdescrp,
        "AVBAL": avbal,
        "LGBAL": lgbal,
        "CURR": curr,
        "ACTYPE": actype,
        "LOCALEQV_AVBAL": localeqvAvbal,
        "ACCOUNT_MANDATE": accountMandate,
      };
}
*/
class LoansList {
  LoansList({
    this.facilityNo,
    this.isoCode,
    this.loanBalance,
    this.description,
    this.amountGranted,
  });

  String facilityNo;
  String isoCode;
  double loanBalance;
  String description;
  String amountGranted;

  factory LoansList.fromJson(Map<String, dynamic> json) => LoansList(
        facilityNo: json["FACILITY_NO"],
        isoCode: json["ISO_CODE"],
        loanBalance: json["LOAN_BALANCE"].toDouble(),
        description: json["DESCRIPTION"],
        amountGranted: json["AMOUNT_GRANTED"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "FACILITY_NO": facilityNo,
        "ISO_CODE": isoCode,
        "LOAN_BALANCE": loanBalance,
        "DESCRIPTION": description,
        "AMOUNT_GRANTED": amountGranted,
      };
}

class Menu {
  Menu({
    this.label,
    this.grouping,
    this.parentId,
    this.typeCode,
    this.quickActFlag,
    this.formCode,
    this.subMenus,
  });

  String label;
  String grouping;
  String parentId;
  TypeCode typeCode;
  QuickActFlag quickActFlag;
  String formCode;
  List<Menu> subMenus;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        label: json["label"],
        grouping: json["grouping"],
        parentId: json["parentId"],
        typeCode: typeCodeValues.map[json["typeCode"]],
        quickActFlag: quickActFlagValues.map[json["quickActFlag"]],
        formCode: json["formCode"] == null ? null : json["formCode"],
        subMenus: json["subMenus"] == null
            ? null
            : List<Menu>.from(json["subMenus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "grouping": grouping,
        "parentId": parentId,
        "typeCode": typeCodeValues.reverse[typeCode],
        "quickActFlag": quickActFlagValues.reverse[quickActFlag],
        "formCode": formCode == null ? null : formCode,
        "subMenus": subMenus == null
            ? null
            : List<dynamic>.from(subMenus.map((x) => x.toJson())),
      };
}

enum QuickActFlag { N, Y }

final quickActFlagValues =
    EnumValues({"N": QuickActFlag.N, "Y": QuickActFlag.Y});

enum TypeCode { M, F }

final typeCodeValues = EnumValues({"F": TypeCode.F, "M": TypeCode.M});

class SecQuestionsList {
  SecQuestionsList({
    this.qCode,
    this.qDescription,
  });

  String qCode;
  String qDescription;

  factory SecQuestionsList.fromJson(Map<String, dynamic> json) =>
      SecQuestionsList(
        qCode: json["Q_CODE"],
        qDescription: json["Q_DESCRIPTION"],
      );

  Map<String, dynamic> toJson() => {
        "Q_CODE": qCode,
        "Q_DESCRIPTION": qDescription,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
