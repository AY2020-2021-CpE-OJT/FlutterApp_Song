import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostData.dart';


var lname, fname;
var phone_number;

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
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                      icon: PhoneIcon(context),
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: controllerThree,
                ),
              ),
            ],
          ),
        ),

            SizedBox(height: 20),
            // Add Button
            Container(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 400,height: 30),
                child: ElevatedButton(
                  onPressed: (){
                    //get value from the text
                    fname = controllerOne.text;
                    lname = controllerTwo.text;
                    phone_number = controllerThree.text;
                    //print the inserted Data
                    print("$fname $lname \n$phone_number");
                    postData(lname, fname, phone_number);

                    //clear the text feild
                    controllerOne.clear();
                    controllerTwo.clear();
                    controllerThree.clear();

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
          child: personIcon(context)),

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

Widget personIcon(BuildContext context){
  return Icon(Icons.person_add, color: Colors.pink);
}

Widget PhoneIcon(BuildContext context){
  return Icon(Icons.phone,color: Colors.pink);
}


Future<PostData> postData(String lname, String fname, String phone_number) async {
  final url = "https://enigmatic-fjord-21038.herokuapp.com/new";

  //call http
  final response = await http.post(Uri.parse(url), body: {
    "lname": lname,
    "fname": fname,
    "phone_number": phone_number
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return postDataFromJson(responseString);
  }

  return postDataFromJson(response.body);
}