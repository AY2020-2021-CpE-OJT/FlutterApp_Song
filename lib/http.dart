import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JSONGet extends StatefulWidget {
  const JSONGet({Key? key}) : super(key: key);

  @override
  _JSONGetState createState() => _JSONGetState();
}

class _JSONGetState extends State<JSONGet> {
  
  Future<String> getData() async {
    http.Response response = await http.get(Uri.parse("https://enigmatic-fjord-21038.herokuapp.com/"),headers: {"Accept": "application/json"});
    print(response.body);
    List data = jsonDecode(response.body);
    print("###");
    print(data[0]);
    return getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new ElevatedButton(onPressed: (){getData();}, child: Text("Get")),
      ),
    );
  }
}


