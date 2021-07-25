import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addDataPage.dart';
import '../Page/EditDataPage.dart';

//Make class to restore the Data
class MainPage extends StatefulWidget {
  final token;
  const MainPage({Key? key, this.token}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List data = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchData();
  }

  //fetch from the API
  fetchData() async{


    setState(() {
      isLoading = true;
    });

    final token = widget.token.toString();
    print(token);
    final url = "https://contactbookapi.herokuapp.com/";
    var response = await http.get(Uri.parse(url),
        headers: {
          //"Accept" : "application/json",
          //"Access-Control_Allow_Origin" : "*",
          "Authorization" : "Bearer $token"});
    if (response.statusCode == 200){
      var item = jsonDecode(response.body);
      print(item);

      //store in the List
      setState(() {
        data =item;
        isLoading = false;
      });
    } else {
      setState(() {
        data = [];
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Phone Book"),
        leading: add(context),
      ),
      body: dataList(),
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.wifi_protected_setup),onPressed: ()=>{Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget))},),
    );
  }

  Widget dataList() {
    // If no data
    if (data.contains(null) || data.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),),);
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
      return individualData(data[index]);
    });
}

Widget individualData(item){

    var fullName = item['fname'] + " " + item['lname'];
    var phoneNumber = item['phone_number'];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          minVerticalPadding: 10
          ,
          leading: CircleAvatar(
            child: Text(item['fname'][0] + item['lname'][0]),
            backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          title: Row(
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  //display name
                  SizedBox(width: MediaQuery.of(context).size.width-190,
                  child: Text(fullName, style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                  
                  SizedBox(height: 10),

                  //display phone number
                  Text(phoneNumber.toString(),style: TextStyle(color: Colors.grey),)
                ],
              ),

              // Edit data
              IconButton(onPressed: (){

                //move to Edit Page
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => edit(passedID: item['_id'], passedLname: item['lname'], passedFname: item['fname'], passedPhonenumber: item['phone_number']))).then((value) => setState((){}));

              }, icon: Icon(Icons.edit)),

              //Delete button
              IconButton(
                  onPressed: () => {delete(item['_id'])},icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
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
}


void delete(String id) async {
  final url = "https://enigmatic-fjord-21038.herokuapp.com/delete/$id";
  
  //call http
  final response = await http.delete(Uri.parse(url));
  
  if (response.statusCode == 200 || response.statusCode == 204){
    return print("Deleted");
  } else {
    print("Failed to Delete");
  }
  return print(response.body);
}