// @dart=2.9

// ignore_for_file: file_names

import 'dart:convert';

TransHistoryModel transHistoryModelFromJson(String str) =>
    TransHistoryModel.fromJson(json.decode(str));

String transHistoryModelToJson(TransHistoryModel data) =>
    json.encode(data.toJson());

class TransHistoryModel {
  TransHistoryModel({
    this.responseCode,
    this.message,
    this.data,
  });

  String responseCode;
  String message;
  List<TransHistoryDatum> data;

  factory TransHistoryModel.fromJson(Map<String, dynamic> json) =>
      TransHistoryModel(
        responseCode: json["responseCode"],
        message: json["message"],
        data: List<TransHistoryDatum>.from(
            json["data"].map((x) => TransHistoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TransHistoryDatum {
  TransHistoryDatum({
    this.narration,
    this.transactionNumber,
    this.postingSysDate,
    this.postingSysTime,
    this.amount,
    this.channel,
    this.branch,
    this.batchNumber,
    this.valueDate,
    this.documentReference,
    this.runningBalance,
    this.imageCheck,
    this.contraAccount,
  });

  dynamic narration;
  String transactionNumber;
  DateTime postingSysDate;
  String postingSysTime;
  String amount;
  String channel;
  dynamic branch;
  String batchNumber;
  DateTime valueDate;
  String documentReference;
  String runningBalance;
  String contraAccount;
  int imageCheck;
  factory TransHistoryDatum.fromJson(Map<String, dynamic> json) =>
      TransHistoryDatum(
        narration: json["narration"],
        transactionNumber: json["transactionNumber"],
        postingSysDate: DateTime.parse(json["postingSysDate"]),
        postingSysTime: json["postingSysTime"],
        amount: json["amount"],
        channel: json["channel"],
        branch: json["branch"],
        batchNumber: json["batchNumber"],
        valueDate: DateTime.parse(json["valueDate"]),
        documentReference: json["documentReference"],
        runningBalance: json["runningBalance"],
        imageCheck: json["imageCheck"],
        contraAccount: json["contraAccount"],
      );

  Map<String, dynamic> toJson() => {
        "narration": narration,
        "transactionNumber": transactionNumber,
        "postingSysDate": postingSysDate.toIso8601String(),
        "postingSysTime": postingSysTime,
        "amount": amount,
        "channel": channel,
        "branch": branch,
        "batchNumber": batchNumber,
        "valueDate": valueDate.toIso8601String(),
        "documentReference": documentReference,
        "runningBalance": runningBalance,
        "contraAccount": contraAccount,
        "imageCheck": imageCheck,
      };
}
