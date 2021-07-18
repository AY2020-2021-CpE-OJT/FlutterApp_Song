import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../CRUD/editData.dart';


var lname, fname;
var phone_number;

final controllerOne = TextEditingController();
final controllerTwo = TextEditingController();
final controllerThree = TextEditingController();

class containData{
  final String id;
  final String lname;
  final String fname;
  final String phone_numer;

  containData(this.id, this.lname, this.fname, this.phone_numer);
}

class edit extends StatelessWidget {
  //contain the passed data
  final containData dataId;

  //get the data
  const edit({Key? key, required this.dataId}) : super(key: key);

  //getting data from the PhoneBook page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Contact",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: input(containData),
    );
  }
}

Widget input(containData) {
  return Center(
    child: Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Container(
          child: Column(children: [
            //Name container
            Container(
                  child: insertName(containData.toString(lname),containData.toString(fname)),
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
                          icon: Icon(Icons.phone,color: Colors.pink),
                          hintText: phone_number,
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


                    //clear the text feild
                    controllerOne.clear();
                    controllerTwo.clear();
                    controllerThree.clear();


                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(primary: Colors.pink),
                ),
              ),
            ),
          ]) //Column
      ),
    ),
  );
}

Widget insertName(String lname, String fname,) {
  return Row(

    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Icon(Icons.person_add, color: Colors.pink)
      ),

      SizedBox(width: 17),
      //name
      Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: fname,
                    hintStyle: TextStyle(color: Colors.grey[600])),
                controller: controllerOne,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: lname,
                    hintStyle: TextStyle(color: Colors.grey[600])),
                controller: controllerTwo,
              )
            ],
          )),
    ],
  );
}

// Update
Future<EditData> editData(String lname,String fname, String phone_number) async {
  final url = "https://enigmatic-fjord-21038.herokuapp.com/";

  //call http
  final response = await http.patch(Uri.parse(url), body: {
    "lname": lname,
    "fname": fname,
    "phone_number": phone_number
  });

  if (response.statusCode == 200) {
    return editDataFromJson("Updated");
  } else {
    return editDataFromJson("Failed to update");
  }
}