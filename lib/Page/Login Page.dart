import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task3_3/Page/registerPage.dart';

import '../Firebase/user.dart';
import 'Phonebook.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log in"),
          titleTextStyle: TextStyle(fontSize: 30),
          centerTitle: true,
        ),
        body: _Login());
  }
}

// form state key
final formKey = GlobalKey<FormState>();

class _Login extends StatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool obscure = true;
  bool? success;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username
            SizedBox(
                width: 300,
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter username"),
                  validator: (username) {
                    if (username == "") {
                      return "Please enter a username";
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
                  controller: passwordController,
                  obscureText: obscure,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),

                      // show password or not
                      suffixIcon: obscure == false
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                obscure = !obscure;
                              }),
                              icon: Icon(Icons.visibility_off),
                            )
                          : IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                obscure = !obscure;
                              }),
                              icon: Icon(Icons.visibility),
                            ),
                      hintText: "Enter password",
                      errorText: success == false
                          ? "User is not exist or wrong password."
                          : null),
                  validator: (password) {
                    if (password == "") {
                      return "Please enter a password";
                    }
                    return null;
                  },
                )),

            //
            SizedBox(height: 40),

            // Login button
            SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      User user = User(
                          username: usernameController.text,
                          password: passwordController.text);

                      success = await user.login();

                      // change the success value
                      setState(() => success);

                      // if the text field is validated
                      if (formKey.currentState!.validate()) {
                        // if the login is successful
                        if (success!) {
                          Navigator.of(context).pushReplacement(PageTransition(
                              child: MainPage(),
                              type: PageTransitionType.fade));
                        }
                      }
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(fontSize: 25),
                    ))),

            //
            SizedBox(height: 40),

            // Sign up
            TextButton(
                style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: Register(), type: PageTransitionType.rightToLeft));
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    ));
  }
}
