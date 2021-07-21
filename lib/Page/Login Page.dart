import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(top: 50),
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
                  )),
                )
              ],
            ),
          ),
          
          //Button
          Container(
            child: ConstrainedBox(constraints: BoxConstraints.tightFor(width: 350, height: 40),
              child: ElevatedButton(
                onPressed: (){

                },
                child: Text("Login"),

              ),
            ),
          )
          
        ],
      ),
    ),
  );
}
