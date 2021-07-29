import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task3_3/Page/EditDataPage.dart';

var lname, fname;
late List<String> phoneNumber = [];

final controllerOne = TextEditingController();
final controllerTwo = TextEditingController();
final controllerThree = TextEditingController();
int num = 1;

class add_new extends StatefulWidget {
  final token;

  const add_new({Key? key, required this.token}) : super(key: key);

  @override
  _add_newState createState() => _add_newState();
}

class _add_newState extends State<add_new> {
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
  }

  void addPhoneNumber() {
    setState(() {
      num++;
      phoneNumberControllers.add(TextEditingController());
    });
  }

  void deletePhoneNumber() {
    setState(() {
      num--;
      phoneNumberControllers.removeAt(num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Adding new Contact",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Column(children: [
                //Name container
                Container(
                  child: insertName(context),
                ),
                SizedBox(height: 30),

                Flexible(
                  child: Container(
                      width: 340,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            phoneNumberControllers.add(TextEditingController());
                            return TextField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.phone),
                                  focusColor: Colors.pink,
                                  labelText: "Phone number #${index + 1}"),
                              controller: phoneNumberControllers[index],
                            );
                          },
                          itemCount: num)),
                ),
                SizedBox(height: 20),
                //Add or delte button
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.pink),
                          child:
                              // Add Phone number
                              IconButton(
                                  onPressed: () => addPhoneNumber(),
                                  icon: Icon(Icons.add_call),
                                  color: Colors.white),

                          //Delete Phone number
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.pink),
                          child:
                              // Add Phone number
                              IconButton(
                                  onPressed: () => deletePhoneNumber(),
                                  icon: Icon(Icons.backspace_outlined),
                                  color: Colors.white),

                          //Delete Phone number
                        ),
                      ]),
                ),

                SizedBox(height: 10),
                // Add Button
                Container(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 400, height: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        //get value from the text
                        fname = controllerOne.text;
                        lname = controllerTwo.text;

                        for (int i = 0; i < num; i++) {
                          phoneNumber.add(phoneNumberControllers[i].text);
                        }
                        print("$fname $lname" + phoneNumber.toString());
                        postData(lname, fname, phoneNumber, widget.token);

                        controllerOne.clear();
                        controllerTwo.clear();

                        for (int i = 0;
                            i < phoneNumberControllers.length;
                            i++) {
                          phoneNumberControllers[i].clear();
                          phoneNumber.clear();
                        }

                        showSnackbar(context);
                      },
                      child: Text("Add"),
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ]) //Column

              ),
        ));
  }
}

showSnackbar(BuildContext context) {
  final toast = SnackBar(content: Text("Successfully Add!"));
  ScaffoldMessenger.of(context).showSnackBar(toast);
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

Widget personIcon(BuildContext context) {
  return Icon(Icons.person_add, color: Colors.pink);
}

Widget PhoneIcon() {
  return Icon(Icons.phone, color: Colors.pink);
}

void postData(
    String lname, String fname, List phone_number, String token) async {
  final url = "https://contactbookapi.herokuapp.com/new";

  //call http
  final response = await http.post(Uri.parse(url), body: {
    "lname": lname,
    "fname": fname,
    "phone_number": phone_number.toSet().toString()
  }, headers: {
    "Authorization": "Bearer $token"
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    print(responseString);
  }
}
