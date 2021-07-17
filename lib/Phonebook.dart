import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addDataPage.dart';

//Make class to restore the Data
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

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

    final url = "https://enigmatic-fjord-21038.herokuapp.com/";
    var response = await http.get(Uri.parse(url), headers: {"Accept" : "application/json", "Access-Control_Allow_Origin" : "*"});
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
          title: Row(
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  //display name
                  SizedBox(width: MediaQuery.of(context).size.width-140,
                  child: Text(fullName, style: TextStyle(fontSize: 17),)),
                  
                  SizedBox(height: 10),

                  //display phone number
                  Text(phoneNumber.toString(),style: TextStyle(color: Colors.grey),)
                ],
              )
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

