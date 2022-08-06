// @dart=2.9

// ignore_for_file: file_names

import 'dart:convert';

PaymentTypeModel paymentTypeModelFromJson(String str) =>
    PaymentTypeModel.fromJson(json.decode(str));

String paymentTypeModelToJson(PaymentTypeModel data) =>
    json.encode(data.toJson());

class PaymentTypeModel {
  PaymentTypeModel({
    this.responseCode,
    this.message,
    this.data,
  });

  String responseCode;
  String message;
  List<PaymentDatum> data;

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      PaymentTypeModel(
        responseCode: json["responseCode"],
        message: json["message"],
        data: List<PaymentDatum>.from(
            json["data"].map((x) => PaymentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PaymentDatum {
  PaymentDatum({
    this.paymentType,
    this.description,
    this.label,
    this.paySubTypes,
  });

  String paymentType;
  String description;
  String label;
  List<PaySubType> paySubTypes;

  factory PaymentDatum.fromJson(Map<String, dynamic> json) => PaymentDatum(
        paymentType: json["paymentType"],
        description: json["description"],
        label: json["label"],
        paySubTypes: List<PaySubType>.from(
            json["paySubTypes"].map((x) => PaySubType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "paymentType": paymentType,
        "description": description,
        "label": label,
        "paySubTypes": List<dynamic>.from(paySubTypes.map((x) => x.toJson())),
      };
}

class PaySubType {
  PaySubType({
    this.paymentAccount,
    this.paymentCode,
    this.paymentLabel,
    this.paymentLogo,
    this.paymentDescription,
  });

  String paymentAccount;
  String paymentCode;
  String paymentLabel;
  String paymentLogo;
  String paymentDescription;

  factory PaySubType.fromJson(Map<String, dynamic> json) => PaySubType(
        paymentAccount: json["paymentAccount"],
        paymentCode: json["paymentCode"],
        paymentLabel: json["paymentLabel"],
        paymentLogo: json["paymentLogo"],
        paymentDescription: json["paymentDescription"],
      );

  Map<String, dynamic> toJson() => {
        "paymentAccount": paymentAccount,
        "paymentCode": paymentCode,
        "paymentLabel": paymentLabel,
        "paymentLogo": paymentLogo,
        "paymentDescription": paymentDescription,
      };
}
