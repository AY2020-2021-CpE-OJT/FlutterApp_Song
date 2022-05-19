import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Page/Login Page.dart';
import 'firebase_options.dart';

void main() async {
  // Connect to Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

Color seedColor = Colors.pink;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Phone Book",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor, brightness: Brightness.light),
        ),
        home: LoginPage());
  }
}
