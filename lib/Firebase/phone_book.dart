import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneBook {
  getData() async {
    var data = await FirebaseFirestore.instance.collection('Phone Book').get();
    print(data.docs);
    return data.docs;
  }
}
