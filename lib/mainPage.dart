import 'package:flutter/material.dart';
import 'adding.dart';

class mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Phone Book"),
          leading: add(context),
        ),
        body: show(context));
  }
}

Widget show(BuildContext context) {
  return Center(
    child: Text("Hi"),
  );

}

Widget add(BuildContext context) {
  return IconButton(
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => add_new()))
      },
      icon: Icon(Icons.add));
}
