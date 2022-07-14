import 'package:flutter/material.dart';

import '../Firebase/user.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

GlobalKey _registerFormKey = GlobalKey<FormState>();

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(),
      usernameController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Register"),
        titleTextStyle: TextStyle(fontSize: 30),
        centerTitle: true,
      ),
      body: Form(
        key: _registerFormKey,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name
            SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hintText: "Enter your name"),
                  validator: (name) {
                    if (name == "") {
                      return "Please enter your name";
                    }
                    return null;
                  },
                )),

            //
            SizedBox(
              height: 30,
            ),

            // Username
            SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: "Enter username"),
                  validator: (username) {
                    if (username == "") {
                      return "Please fill the username";
                    }
                    return null;
                  },
                )),

            //
            SizedBox(
              height: 30,
            ),

            // Password
            SizedBox(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: "Enter password"),
                  validator: (password) {
                    if (password == "") {
                      return "Please fill the password";
                    }
                    return null;
                  },
                )),

            //
            SizedBox(
              height: 40,
            ),

            // Register
            SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      // create a new user instance
                      User user = User(
                          name: nameController.text,
                          username: usernameController.text,
                          password: passwordController.text);

                      // register
                      // if (_registerFormKey.currentState.) {
                      bool success = await user.register();
                    }

                    // }
                    ,
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 30),
                    )))
          ],
        )),
      ),
    );
  }
}
