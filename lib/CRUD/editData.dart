// To parse this JSON data, do
//
//     final editData = editDataFromJson(jsonString);

import 'dart:convert';

EditData editDataFromJson(String str) => EditData.fromJson(json.decode(str));

String editDataToJson(EditData data) => json.encode(data.toJson());

class EditData {
  EditData({
    required this.lname,
    required this.fname,
    required this.phoneNumber,
  });

  String lname;
  String fname;
  String phoneNumber;

  factory EditData.fromJson(Map<String, dynamic> json) => EditData(
    lname: json["lname"],
    fname: json["fname"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "lname": lname,
    "fname": fname,
    "phone_number": phoneNumber,
  };
}
