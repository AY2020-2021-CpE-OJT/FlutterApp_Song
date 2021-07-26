import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

var lname, fname;
List phone_number = [];

final controllerOne = TextEditingController();
final controllerTwo = TextEditingController();
List<TextEditingController> controllerThree = <TextEditingController>[TextEditingController()];

class add_new extends StatefulWidget {
  final token;
  const add_new({Key? key, this.token}) : super(key: key);

  @override
  _add_newState createState() => _add_newState();
}

class _add_newState extends State<add_new> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {

    List<Widget> _phoneNumberField = new List.generate(_count, (int i) => new ContactColumn());
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
        centerTitle: true,
        title: Text(
          "Adding new Contact",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: //input(context,widget.token),
             LayoutBuilder(builder: (context, constraint){
              return  Center(
                  child:Container(
                    padding: EdgeInsets.only(top: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Name
                        Container(
                          child: insertName(context),
                        ),

                        Divider(
                          color: Colors.pink,
                          thickness: 3,
                          height: 30,
                          indent: 10,

                        ),

                        //Phone Number
                        Container(
                          height: 100.0,
                          child: Row(
                            children: [
                              Container(
                                child: new ListView(
                                  children: _phoneNumberField,
                                  scrollDirection: Axis.vertical,
                                ),
                                width: 390,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.pink),
                              child: IconButton(
                              onPressed: (){
                                _addNewContact();
                                phone_number.add(controllerThree[_count].text);
                                print(phone_number);
                              },
                              icon: Icon(Icons.add,color: Colors.white,),
                          ),
                            ),

                            SizedBox(width: 10,),

                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.pink),
                              child: IconButton(
                                onPressed: (){
                                  if (_count > 1){
                                    _deleteContact();
                                  }
               },
                                icon: Text("ㅡ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),

                            SizedBox(height: 10,),
                          ],
                        ),

                        SizedBox(height: 20,),

                        //Save Button
                        Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 350,height: 40),
                            child: ElevatedButton(
                              onPressed: (){
                                //get value from the text
                                fname = controllerOne.text;
                                lname = controllerTwo.text;
                                phone_number.add(controllerThree[_count].text);
                                //print the inserted Data
                                print("$fname $lname \n$phone_number");
                                postData(lname, fname, phone_number,widget.token);

                                //clear the text feild
                                controllerOne.clear();
                                controllerTwo.clear();
                                controllerThree.clear();

                                showSnackbar(context);

                              },
                              child: Text("Add"),
                              style: ElevatedButton.styleFrom(primary: Colors.pink),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
              );
            })
    );
  }
  void _addNewContact(){
    setState(() {
      _count += 1;
    });
  }

  void _deleteContact(){
    setState(() {
      _count -= 1;
    });
  }

}

// Widget input(BuildContext context,String token) {
//   return Center(
//     child: Container(
//       alignment: Alignment.topCenter,
//       padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
//       child: Container(
//           child: Column(children: [
//             //Name container
//             Container(
//               child: insertName(context),
//             ),
//             SizedBox(height: 30),
//             //Phone number container
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 300,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         labelText: "Phone number",
//                           labelStyle: TextStyle(color: Colors.grey),
//                           icon: PhoneIcon(context),
//                           hintStyle: TextStyle(color: Colors.grey)),
//                       controller: controllerThree,
//                     ),
//                   ),
//                   SizedBox(width: 10,),
//
//                   //Add more phone number
//                   Container(
//                     width: 40,
//                     height: 40,
//                     child: Ink(
//                     decoration: ShapeDecoration(
//                       color: Colors.pink,
//                       shape: CircleBorder(),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.add,color: Colors.white,),
//                       onPressed: () { phone_number.add(controllerThree.text); },
//                     ),
//                   ),)
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20),
//             // Add Button
//             Container(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints.tightFor(width: 400,height: 40),
//                 child: ElevatedButton(
//                   onPressed: (){
//                     //get value from the text
//                     fname = controllerOne.text;
//                     lname = controllerTwo.text;
//                     phone_number.add(controllerThree.text);
//                     //print the inserted Data
//                     print("$fname $lname \n$phone_number");
//                     postData(lname, fname, phone_number,token);
//
//                     //clear the text feild
//                     controllerOne.clear();
//                     controllerTwo.clear();
//                     controllerThree.clear();
//
//                     showSnackbar(context);
//
//                   },
//                   child: Text("Add"),
//                   style: ElevatedButton.styleFrom(primary: Colors.pink),
//                 ),
//               ),
//             ),
//           ]) //Column
//       ),
//     ),
//   );
// }

showSnackbar(BuildContext context){
  final toast = SnackBar(content: Text("Successfully Add!"));
  ScaffoldMessenger.of(context).showSnackBar(toast);
}

Widget insertName(BuildContext context) {
  return Row(

    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: personIcon(context)),

      SizedBox(width: 17),
      //name
      Container(
          width: 310,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "First name",
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey[600])),
                controller: controllerOne,
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    labelText: "Last name",
                    labelStyle: TextStyle(color: Colors.grey),
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

void postData(String lname, String fname, List phone_number,String token) async {
  final url = "https://contactbookapi.herokuapp.com/new";

  //call http
  final response = await http.post(Uri.parse(url), body: {
    "lname": lname,
    "fname": fname,
    "phone_number": phone_number
  },headers: {"Authorization": "Bearer $token"});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    print(responseString);
  }
}

class ContactColumn extends StatefulWidget {
  const ContactColumn({Key? key}) : super(key: key);

  @override
  _ContactColumnState createState() => _ContactColumnState();
}

class _ContactColumnState extends State<ContactColumn> {
  int controller = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.setController();
  }

  setController() async{
    setState(() {
      controller += 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child:  Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 23)),
          Icon(Icons.phone,color: Colors.pink,),
          Padding(padding: EdgeInsets.only(left: 15),),
          Container(
            width: 310,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.number,
                  controller: controllerThree[],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}