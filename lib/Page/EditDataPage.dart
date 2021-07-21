import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var lname,fname,phone_number;

final controllerOne = TextEditingController();
final controllerTwo = TextEditingController();
final controllerThree = TextEditingController();

class edit extends StatelessWidget {
  //contain the passed data
  final String passedID,passedLname,passedFname,passedPhonenumber;
  //get the data
  const edit({Key? key, required this.passedID, required this.passedLname,required this.passedFname, required this.passedPhonenumber}) : super(key: key);
  //url

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
      body: input(passedID,passedFname,passedLname,passedPhonenumber),
    );
  }
}

Widget input(String passedID, String passedFname, String passedLname, String passedPhonenumber) {
  return Center(
    child: Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Container(
          child: Column(children: [
            //Name container
            Container(
                  child: insertName(passedFname,passedLname),
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
                          hintText: passedPhonenumber,
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
                constraints: BoxConstraints.tightFor(width: 400,height: 40),
                child: ElevatedButton(
                  onPressed: (){

                    //get value from the text
                    if (controllerOne.text.isNotEmpty){
                      fname = controllerOne.text;
                    } else {
                      fname = passedFname;
                    }

                    if (controllerTwo.text.isNotEmpty){
                      lname = controllerTwo.text;
                    } else {
                     lname = passedLname;
                    }

                    if (controllerThree.text.isNotEmpty){
                      phone_number = controllerThree.text;
                    } else {
                      phone_number = passedPhonenumber;
                    }
                    //print the inserted Data
                    print("$fname $lname \n$phone_number");

                    //updata data
                    updateData(passedID,lname, fname, phone_number);


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

//Update
void updateData(String id, String lname,String fname, String phone_number) async {
  final url = "https://enigmatic-fjord-21038.herokuapp.com/update/$id";

  final response = await http.patch(Uri.parse(url),body: {
    "lname" : lname,
    "fname" : fname,
    "phone_number" : phone_number
  });

  if (response.statusCode == 200) {
    return print("Updated");
  } else {
    return print("Failed to update id : $id, $fname $lname, $phone_number \n${response.statusCode}");
  }
}