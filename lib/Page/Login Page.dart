import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Phonebook.dart';
import 'registerPage.dart';

var name , password;
final nameController = TextEditingController(), passwordController = TextEditingController();


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in / Sign in"),
        centerTitle: true,
      ),
      body: login(context),
    );
  }
}

Widget login(BuildContext context) {
  return Center(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Alert
          Text(""),

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
                      decoration: InputDecoration(hintText: "Enter your name"),
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
                        InputDecoration(hintText: "Enter your password"),
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
                  loginAPI(name, password, context);
                },
                child: Text("Login"),

              ),
            ),
          ),
          SizedBox(height: 15),

          //Register
          TextButton(
            onPressed: () { Navigator.push(
                context, MaterialPageRoute(builder: (context) => register())); },
            child: Text("Sign up",style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 20),),

          )
          
        ],
      ),
    ),
  );
}

void loginAPI(String name, String password, BuildContext context) async {
  final url =  "https://contactbookapi.herokuapp.com/token/login";
  final response = await http.post(Uri.parse(url),body: {
    'name' : name,
    'password' : password
  });
  var item = jsonDecode(response.body);
  if (item['user']['message'] != "User doesn't Exist!"){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage(token : item['token'])));
  } else {
    showAlertDialog(context);
  }

}

showAlertDialog (BuildContext context){
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.pop(context); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      child: Row(
        children: [
          Icon(Icons.warning,color: Colors.yellow,),
          SizedBox(width: 10,),
          Text("Warning!")
        ],
      ),
    ),

    content: Text("User is not Exist!"),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}