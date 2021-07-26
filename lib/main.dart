import 'package:flutter/material.dart';
import 'Page/Login Page.dart';
import './Page/Textfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Phone Book",
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),

      home: LoginPage()
    );
  }
}
