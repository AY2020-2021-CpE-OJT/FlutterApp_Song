import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task3_3/Page/Login%20Page.dart';
import '../Firebase/phone_book.dart';

class PhoneBookDisplay extends StatelessWidget {
  const PhoneBookDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            // Logout
            TextButton(
          onPressed: () {
            // Log out and go back to the Login page
            Navigator.of(context).pushReplacement(PageTransition(
                child: LoginPage(), type: PageTransitionType.fade));
          },
          child: Text(
            "Log out",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        leadingWidth: 90,

        //
        title: Text(
          "Phone Book",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        // go to add phone data page
        onPressed: () {},
        child: Icon(Icons.add),
      ),

      //
      body: _PhoneBookData(),
    );
  }
}

class _PhoneBookData extends StatefulWidget {
  _PhoneBookData({Key? key}) : super(key: key);

  @override
  State<_PhoneBookData> createState() => __PhoneBookDataState();
}

class __PhoneBookDataState extends State<_PhoneBookData> {
  PhoneBook phonebook = PhoneBook();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: phonebook.getData(),
      builder: (context, snapshot) {
        return ListView.builder(
          // shrinkWrap: true,
          itemCount: phonebook.phoneBook.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Circle Avatar
                    CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    //
                    SizedBox(width: 20),
                    // Information
                    SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${phonebook.phoneBook[index]["last_name"]} , ${phonebook.phoneBook[index]["first_name"]}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            //
                            SizedBox(
                              height: 10,
                            ),

                            // Phone numbers
                            SizedBox(
                              width: 300,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: phonebook
                                    .phoneBook[index]["phone_number"].length,
                                itemBuilder: (BuildContext context,
                                    int phoneNumberIndex) {
                                  return Text(phonebook.phoneBook[index]
                                      ["phone_number"][phoneNumberIndex]);
                                },
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
