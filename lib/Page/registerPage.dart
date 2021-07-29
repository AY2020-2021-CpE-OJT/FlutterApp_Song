import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

final nameController = TextEditingController();
final passwordController = TextEditingController();
var name,password;

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
      ),
      body: Register(context),
    );
  }
}

Widget Register(BuildContext context) {
  return Center(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Enter username icon
                Icon(Icons.person),
                SizedBox(
                  width: 10,
                ),
                //Enter name
                Container(
                    width: 300,
                    child: (TextField(
                      decoration: InputDecoration(labelText: "Enter your name"),
                      controller: nameController,
                    ))),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.vpn_key),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //Enter password
                  width: 300,
                  child: (TextField(
                    decoration:
                    InputDecoration(labelText: "Enter your password"),
                    controller: passwordController,
                  )),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          //Login button
          Container(
            child: ConstrainedBox(constraints: BoxConstraints.tightFor(width: 350, height: 40),
              child: ElevatedButton(
                onPressed: (){
                  name = nameController.text;
                  password = passwordController.text;
                  print(name + " " + password);
                  registerAPI(context,name,password);
                },
                child: Text("Sign up"),

              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void registerAPI(BuildContext context,String name, String password) async{
  final url = "https://contactbookapi.herokuapp.com/token/register";
  final response = await http.post(Uri.parse(url),body: {
    "name" : name,
    "password" : password
  });
  var item = jsonDecode(response.body);
  if (item['message'] == "Successful"){
    showSuccessDialog(context);
  } else {
    showAlertDialog(context);
  }
  print(item);
}

showSuccessDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Success!")
        ],
      ),
    ),
    content: Text("Successfully resgistered"),
    actions: [okButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Warning!")
        ],
      ),
    ),
    content: Text("User is already exist!"),
    actions: [okButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}