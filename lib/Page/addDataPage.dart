import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task3_3/Firebase/phone_book.dart';
import 'package:task3_3/Page/display_phoneBook.dart';

GlobalKey _formKey = GlobalKey<FormState>();

class AddNewContact extends StatefulWidget {
  const AddNewContact({Key? key}) : super(key: key);

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  //
  List phoneNumber = [];
  int phoneNumberListLength = 1;
  //
  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController();
  List<TextEditingController> phoneNumberController = [TextEditingController()];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Contact",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,

        // Add
        actions: [
          TextButton(
              onPressed: () {
                // create instanse of PhoneBook
                PhoneBook phoneBook = PhoneBook();

                // Add new contact
                phoneBook.addData(lastNameController.text,
                    firstNameController.text, phoneNumberController);

                // show toast message
                _showToast(context, "Successfuly add new contact");

                // go back to the main page
                Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.of(context).pushReplacement(PageTransition(
                      child: PhoneBookDisplay(),
                      type: PageTransitionType.topToBottom)),
                );
              },
              child: Text("Add",
                  style: TextStyle(fontSize: 20, color: Colors.white)))
        ],
      ),

      //
      body: Center(
        child: Column(
          children: [
            //
            Spacer(
              flex: 1,
            ),

            // Avatar
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                child: Icon(Icons.person, size: 70),
              ),
            ),

            // name, phone number enter
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //
                  SizedBox(
                    height: 15,
                  ),

                  //
                  name(),

                  //
                  SizedBox(height: 30),

                  // Phone Number Text
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  phone_number(phoneNumberListLength)
                ],
              ),
            ),

            //
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget name() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          // Last name
          TextFormField(
            decoration: InputDecoration(labelText: "Last name"),
            controller: lastNameController,
            validator: (last_name) {
              if (last_name == "") {
                return "Please enter the last name";
              }
              return null;
            },
          ),

          //
          SizedBox(height: 20),

          // First name
          TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First name"),
              validator: (first_name) {
                if (first_name == "") {
                  return "Please enter the first name";
                }
                return null;
              })
        ],
      ),
    );
  }

  Widget phone_number(int length) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView.builder(
        itemCount: length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          // If there is only one phone number
          if (length == 1) {
            return SizedBox(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // phone number input
                Center(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            controller: phoneNumberController[index],
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "Enter phone number"),
                            validator: (phoneNumber) {
                              if (phoneNumber == "") {
                                return "Please enter phone number or remove";
                              }
                              return null;
                            },
                          ),
                        ),

                        // Add more phone number
                        IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                phoneNumberListLength++;
                                phoneNumberController
                                    .add(TextEditingController());
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ));
          }

          if (index != length - 1) {
            return SizedBox(
              child: Center(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          controller: phoneNumberController[index],
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: "Enter phone number"),
                          validator: (phoneNumber) {
                            if (phoneNumber == "") {
                              return "Please enter phone number or remove";
                            }
                            return null;
                          },
                        ),
                      ),

                      // remove phone number
                      IconButton(
                          onPressed: () {
                            setState(() {
                              phoneNumberListLength--;
                              phoneNumberController.removeLast();
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.red,
                          )),

                      // Add more phone number
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.add,
                            color: Colors.transparent,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
          return SizedBox(
            child: Center(
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        controller: phoneNumberController[index],
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Enter phone number"),
                        validator: (phoneNumber) {
                          if (phoneNumber == "") {
                            return "Please enter phone number or remove";
                          }
                          return null;
                        },
                      ),
                    ),

                    // remove phone number
                    IconButton(
                        onPressed: () {
                          setState(() {
                            phoneNumberListLength--;
                            phoneNumberController.removeLast();
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        )),

                    // Add more phone number
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            phoneNumberListLength++;
                            phoneNumberController.add(TextEditingController());
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ),
  );
}
