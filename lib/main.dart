import 'package:flutter/material.dart';
import 'mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone books',
      theme: ThemeData(primaryColor: Colors.pink),
      home: mainpage(),
    );
  }
}
