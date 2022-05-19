import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PhoneBook {
  List phoneBook = [];
  // fetch data
  Future getData() async {
    phoneBook.clear();
    var data = await FirebaseFirestore.instance.collection('Phone Book').get();
    for (int i = 0; i < data.docs.length; i++) {
      phoneBook.add(data.docs[i]);
    }
  }

  // add data
  Future addData(String lastName, String firstName,
      List<TextEditingController> phoneNumberController) async {
    // phone number list
    List<String> phoneNumber = [];

    // get the phone number form the controller and add to the phone number list
    for (int i = 0; i < phoneNumberController.length; i++) {
      phoneNumber.add(phoneNumberController[i].text);
    }

    // convert into map
    Map<String, dynamic> data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber
    };

    print(data);

    await FirebaseFirestore.instance.collection("Phone Book").add(data);
  }

  // remove data
  Future<bool> removeData(var data) async {
    return false;
  }

  // update data
  Future<bool> uapdateData(String id) async {
    return false;
  }
}
