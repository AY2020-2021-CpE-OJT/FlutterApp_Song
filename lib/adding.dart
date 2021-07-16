import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var lname = "", fname = "";
var phone_number = "";

final controllerOne = TextEditingController();
final controllerTwo = TextEditingController();
final controllerThree = TextEditingController();

class add_new extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Adding new Contact",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: input(context),
    );
  }
}

Widget input(BuildContext context) {
  return Center(
    child: Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(50),
      child: Container(
          child: Column(children: [
        //Name container
        Container(
          child: insertName(context),
        ),
        SizedBox(height: 30),
        //Phone number container
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 340,
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: controllerThree,
                ),
              ),
            ],
          ),
        ),

            SizedBox(height: 10),
            // Add Button
            Container(
              padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300,height: 30),
                child: ElevatedButton(
                  onPressed: (){
                    fname = controllerOne.text;
                    lname = controllerTwo.text;
                    //get int value
                    phone_number = controllerThree.text;
                    //print the inserted Data
                    print("$fname $lname \n$phone_number");
                  },
                  child: Text("Add"),
                  style: ElevatedButton.styleFrom(primary: Colors.pink),
                ),
              ),
            ),
      ]) //Column
          ),
    ),
  );
}

Widget insertName(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Icon(Icons.person_add, color: Colors.grey)),

      SizedBox(width: 17),
      //name
      Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  decoration: InputDecoration(
                      hintText: "First name",
                      hintStyle: TextStyle(color: Colors.grey[600])),
              controller: controllerOne,
              ),
              TextField(
                  decoration: InputDecoration(
                      hintText: "Last name",
                      hintStyle: TextStyle(color: Colors.grey[600])),
              controller: controllerTwo,
              )
            ],
          )),
    ],
  );
}
