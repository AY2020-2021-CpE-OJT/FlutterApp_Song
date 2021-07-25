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
