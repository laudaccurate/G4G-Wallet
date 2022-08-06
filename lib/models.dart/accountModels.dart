// @dart=2.9

// ignore_for_file: file_names

import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.responseCode,
    this.message,
    this.data,
  });

  String responseCode;
  String message;
  List<AccountModelDatum> data;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        responseCode: json["responseCode"],
        message: json["message"],
        data: List<AccountModelDatum>.from(
            json["data"].map((x) => AccountModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AccountModelDatum {
  AccountModelDatum({
    this.customerNumber,
    this.accountNumber,
    this.accountDesc,
    this.accountType,
    this.currency,
    this.currencyCode,
    this.ledgerBalance,
    this.availableBalance,
    this.localEquivalentAvailableBalance,
    this.accountMandate,
    this.accountBranch,
  });

  String customerNumber;
  String accountNumber;
  String accountDesc;
  String accountType;
  String currency;
  String currencyCode;
  String ledgerBalance;
  String availableBalance;
  String localEquivalentAvailableBalance;
  String accountMandate;
  String accountBranch;

  factory AccountModelDatum.fromJson(Map<String, dynamic> json) =>
      AccountModelDatum(
        customerNumber: json["customerNumber"],
        accountNumber: json["accountNumber"],
        accountDesc: json["accountDesc"],
        accountType: json["accountType"],
        currency: json["currency"],
        currencyCode: json["currencyCode"],
        ledgerBalance: json["ledgerBalance"],
        availableBalance: json["availableBalance"],
        localEquivalentAvailableBalance:
            json["localEquivalentAvailableBalance"],
        accountMandate: json["accountMandate"],
        accountBranch: json['accountBranch'],
      );

  Map<String, dynamic> toJson() => {
        "customerNumber": customerNumber,
        "accountNumber": accountNumber,
        "accountDesc": accountDesc,
        "accountType": accountType,
        "currency": currency,
        "currencyCode": currencyCode,
        "ledgerBalance": ledgerBalance,
        "availableBalance": availableBalance,
        "localEquivalentAvailableBalance": localEquivalentAvailableBalance,
        "accountMandate": accountMandate,
        "accountBranch": accountBranch,
      };
}
