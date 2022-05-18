import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneBook {
  List phoneBook = [];
  // fetch data
  Future getData() async {
    phoneBook.clear();
    var data = await FirebaseFirestore.instance.collection('Phone Book').get();
    for (int i = 0; i < data.docs.length; i++) {
      phoneBook.add(data.docs[i].data());
    }
  }

  // add data
  Future<bool> addData() async {
    return false;
  }

  // remove data
  Future<bool> removeData() async {
    return false;
  }

  // update data
  Future<bool> updateData() async {
    return false;
  }
}
