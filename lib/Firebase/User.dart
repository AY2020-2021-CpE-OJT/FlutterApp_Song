import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username, password, name;

  User({required this.username, required this.password, this.name = ""});

  Future<bool> login() async {
    final userInfo = await FirebaseFirestore.instance.collection("user").get();

    for (int i = 0; i < userInfo.docs.length; i++) {
      if (username == userInfo.docs[i].data()['userId'] &&
          password == userInfo.docs[i].data()['password']) {
        return true;
      }
    }
    return false;
  }

  Future<bool> register() async {
    await FirebaseFirestore.instance
        .collection("user")
        .add({"name": name, "userId": username, "password": password});

    return true;
  }
}
