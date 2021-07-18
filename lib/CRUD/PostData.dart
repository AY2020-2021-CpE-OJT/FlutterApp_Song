// To parse this JSON data, do
//
//     final postData = postDataFromJson(jsonString);
// Used generating tool
import 'dart:convert';


PostData postDataFromJson(String str) => PostData.fromJson(json.decode(str));

String postDataToJson(PostData data) => json.encode(data.toJson());

class PostData {
  PostData({
    required this.lname,
    required this.fname,
    required this.phoneNumber,
  });

  String lname;
  String fname;
  String phoneNumber;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
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