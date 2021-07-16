import 'package:flutter/material.dart';
import 'Phonebook.dart';
import 'adding.dart';

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

      home: MainPage(),
    );
  }
}


//Main Home
// class mainHome extends StatefulWidget {
//   const mainHome({Key? key}) : super(key: key);
//
//   @override
//   _mainHomeState createState() => _mainHomeState();
// }

// class _mainHomeState extends State<mainHome> {
//
//   late Future<PhoneData> futureData;
//
//   @override
//   void initState(){
//     super.initState();
//     futureData = fetchData();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Phone Book"),
//         leading: add(context),
//       ),
//       body: Center(
//         child: FutureBuilder<PhoneData>(
//           future: futureData,
//           builder: (context, snapshot){
//             if (snapshot.hasData){
//               return Text(snapshot.data!.lname);
//             } else if (snapshot.hasError){
//               return Text("${snapshot.error}");
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }