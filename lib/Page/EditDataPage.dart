import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditContactPage extends StatefulWidget {
  var document;
  EditContactPage({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

GlobalKey _formKey = GlobalKey<FormState>();

class _EditContactPageState extends State<EditContactPage> {
  // Text Editing Controllers
  TextEditingController lastNameController = TextEditingController(),
      firstNameController = TextEditingController();
  List<TextEditingController> phoneNumberController = [];
  int phoneBookListLength = 0;

  // add the phone numbers to text editing controllers' text
  phone_numbers() {
    int phoneNumberListLength = widget.document["phone_number"].length;
    for (int i = 0; i < phoneNumberListLength; i++) {
      phoneNumberController.add(TextEditingController());
      phoneNumberController[i].text = widget.document["phone_number"][i];
    }
  }

  // add phone number
  add_phone_numer() {
    setState(() {
      phoneBookListLength++;
      phoneNumberController.add(TextEditingController());
    });
  }

  // remove phone number
  remove_phone_numer() {
    setState(() {
      phoneBookListLength--;
      phoneNumberController.removeLast();
    });
  }

  @override
  void initState() {
    lastNameController.text = widget.document["last_name"];
    firstNameController.text = widget.document["first_name"];
    phoneBookListLength = widget.document["phone_number"].length;
    phone_numbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title
        title: Text("Edit"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 30),

        //
        actions: [
          // Save Button
          TextButton(
              onPressed: () {},
              child: Text(
                "Save ",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ))
        ],
      ),

      //
      body: content(),
    );
  }

  Widget content() {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        Spacer(
          flex: 1,
        ),
        // Avatar
        CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 75),
        ),

        //
        SizedBox(
          height: 20,
        ),

        // Name and Phone number
        Form(
            key: _formKey,
            child: SizedBox(
              child: textfields(),
            )),

        //
        Spacer(
          flex: 2,
        )
      ],
    ));
  }

  Widget textfields() {
    return Column(
      children: [
        // Last name
        SizedBox(
          width: 200,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: lastNameController,
            decoration: InputDecoration(
                hintText: lastNameController.text, labelText: "Last Name"),
          ),
        ),

        //
        SizedBox(
          height: 20,
        ),

        // First name
        SizedBox(
          width: 200,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: firstNameController,
            decoration: InputDecoration(
                hintText: lastNameController.text, labelText: "First Name"),
          ),
        ),

        //
        SizedBox(
          height: 20,
        ),

        // Phone number text
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "Phone Number",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        //
        SizedBox(
          height: 10,
        ),

        // Phone Numbers
        phone_numbers_display()
      ],
    );
  }

  Widget phone_numbers_display() {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: phoneBookListLength,
        itemBuilder: (BuildContext context, int index) {
          // if there is only one phone number
          if (phoneBookListLength == 1) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                //
                SizedBox(
                  width: 10,
                ),

                // phone number
                SizedBox(
                    width: 150,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: phoneNumberController[index],
                    )),

                // Add new phone number
                IconButton(
                    onPressed: () {
                      // add new phone number
                      add_phone_numer();
                    },
                    icon: Icon(Icons.add, color: Colors.blueAccent))
              ],
            );
          }
          //TODO: find a way to display both add and remove button on the last index of the list
          // if the index is  last
          else if (index == phoneBookListLength) {
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                //
                SizedBox(
                  width: 10,
                ),

                // phone number
                SizedBox(
                    width: 150,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: phoneNumberController[index],
                    )),

                IconButton(
                    onPressed: () {
                      // remove phone number
                      remove_phone_numer();
                    },
                    icon: Icon(Icons.remove, color: Colors.red)),

                IconButton(
                    onPressed: () {
                      // add new phone number
                      add_phone_numer();
                    },
                    icon: Icon(Icons.add, color: Colors.blueAccent))
              ],
            );
          }

          // if the index is not the last
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Icon(
                Icons.phone,
                color: Colors.green,
              ),
              //
              SizedBox(
                width: 10,
              ),

              // phone number
              SizedBox(
                  width: 150,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: phoneNumberController[index],
                  )),

              IconButton(
                  onPressed: () {
                    // remove phone number
                    remove_phone_numer();
                  },
                  icon: Icon(Icons.remove, color: Colors.red)),
            ],
          );
        },
      ),
    );
  }
}
