import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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

GlobalKey formKey = GlobalKey<FormState>();

class _Login extends StatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool showPassword = false;

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
                  obscureText: showPassword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),

                      // show password or not
                      suffixIcon: showPassword == true
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                showPassword = !showPassword;
                              }),
                              icon: Icon(Icons.visibility_off),
                            )
                          : IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                showPassword = !showPassword;
                              }),
                              icon: Icon(Icons.visibility),
                            ),
                      hintText: "Enter password"),
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
                      bool success = await user.login();

                      print(success);

                      if (success) {
                        Navigator.of(context).pushReplacement(PageTransition(
                            child: MainPage(), type: PageTransitionType.fade));
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
                onPressed: () {},
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
