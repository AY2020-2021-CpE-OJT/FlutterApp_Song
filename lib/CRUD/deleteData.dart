// To parse this JSON data, do
//
//     final deleteData = deleteDataFromJson(jsonString);

import 'dart:convert';

DeleteData deleteDataFromJson(String str) => DeleteData.fromJson(json.decode(str));

String deleteDataToJson(DeleteData data) => json.encode(data.toJson());

class DeleteData {
  DeleteData({
   required this.phoneNumber,
  });

  String phoneNumber;

  factory DeleteData.fromJson(Map<String, dynamic> json) => DeleteData(
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
  };
}
