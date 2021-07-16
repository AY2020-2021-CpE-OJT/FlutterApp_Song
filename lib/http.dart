import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

//Make a request to the API
Future<http.Response> getDataFromAPI(){
  return http.get(Uri.parse("https://enigmatic-fjord-21038.herokuapp.com/"));
}

//Make class to restore the Data
class PhoneData {
  final String lname;
  final String fname;
  final String phone_number;

  PhoneData({
    required this.lname,
    required this.fname,
    required this.phone_number
});

  factory PhoneData.fromJson(Map<String, dynamic> json){
    return PhoneData(lname: json['lname'], fname: json['fname'], phone_number: json['phone_number']);
  }
}

//Convert http.Response to an PhoneData()
Future<PhoneData> fetchData() async {
  final response = await http.get(Uri.parse("https://enigmatic-fjord-21038.herokuapp.com/"));

  if (response.statusCode == 200){
    return PhoneData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}
