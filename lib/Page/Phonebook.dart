import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addDataPage.dart';
import '../Page/EditDataPage.dart';
import 'package:animations/animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

RefreshController _refreshController =
RefreshController(initialRefresh: false);

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
  fetchData() async {
    setState(() {
      isLoading = true;
    });

    final token = widget.token.toString();
    print(token);
    final url = "https://contactbookapi.herokuapp.com/";
    var response = await http.get(Uri.parse(url), headers: {
      //"Accept" : "application/json",
      //"Access-Control_Allow_Origin" : "*",
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      print(item);

      //store in the List
      setState(() {
        data = item;
        isLoading = false;
      });
    } else {
      setState(() {
        data = [];
        isLoading = false;
      });
    }
  }

  Widget FAB(BuildContext context) => OpenContainer(
        transitionDuration: Duration(milliseconds: 800),
        closedShape: CircleBorder(),
        closedBuilder: (context, openContainer) => Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
          height: 56,
          width: 56,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        openBuilder: (context, _) => add_new(token: widget.token),
      );


  //refresh related function
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 0));
    setState(() {
      fetchData();
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  //refresh related function
  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 400));
      setState(() {
        fetchData();
      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Phone Book"),
        ),
        body:
        //refresh
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,

          //showing data
          child: dataList(),),
        //dataList(),
        backgroundColor: Colors.grey[400],
        floatingActionButton: FAB(context));
  }

  Widget dataList() {
    // If no data
    if (data.contains(null) || data.length < 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      );
    }
    return
        ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return individualData(data[index]);
            });
  }


  //contain data
  Widget individualData(item) {
    var fullName = item['fname'] + " " + item['lname'];
    var phoneNumber = item['phone_number'];

  //Snack bar
    showSnackbar(BuildContext context,String message){
      final toast = SnackBar(content: Text("$message"));
      ScaffoldMessenger.of(context).showSnackBar(toast);
    }

    //Alert message
    showAlertDialog(BuildContext context, String id, String token) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          delete(id, token);
          fetchData();
          Navigator.pop(context);
          showSnackbar(context, "Succesfully Delete!");
        },
      );
      Widget cancelButton = TextButton(
          onPressed: () {
            fetchData();
            Navigator.pop(context);
          },
          child: Text("cancel"));

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Container(
          child: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Warning!")
            ],
          ),
        ),
        content: Text("Are you sure to delete this contact?"),
        actions: [okButton, cancelButton],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    //swiping function
    return Dismissible(
        key: UniqueKey(),

        //Delete
        secondaryBackground: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ))),

        //Edit
        background: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Icon(Icons.edit),
            ],
          ),
        ),
        onDismissed: (DismissDirection direction) => {
              if (direction == DismissDirection.endToStart){
                showAlertDialog(context, item['_id'], widget.token),
                }
              else
                {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit(
                                  passedID: item['_id'],
                                  passedLname: item['lname'],
                                  passedFname: item['fname'],
                                  passedPhonenumber: item['phone_number'],
                                  token: widget.token,
                                  )))
                      .then((value) => setState(() {
                            fetchData();
                          }))
                }
            },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              minVerticalPadding: 10,
              leading: CircleAvatar(
                child: Text(item['fname'][0] + item['lname'][0]),
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              title: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //display name
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 145,
                          child: Text(
                            fullName,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),

                      SizedBox(height: 10),

                      //display phone number
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.local_phone_rounded),
                            SizedBox(width: 8,),
                            Text(
                              phoneNumber,//.toString().replaceAll('[', '📞 ').replaceAll(',', '\n📞 ').replaceAll(']', ' '),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // go to add page
  Widget add(BuildContext context, String token) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.decelerate);
                    return ScaleTransition(
                        alignment: Alignment.topLeft,
                        child: child,
                        scale: animation);
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return add_new(
                      token: widget.token,
                    );
                  })

              // MaterialPageRoute(
              //     builder: (context) => add_new(token: widget.token))
              ).then((value) => setState(() {
                fetchData();
              }));
        },
        icon: Icon(Icons.add));
  }
}

//delete api
void delete(String id, String token) async {
  final url = "https://contactbookapi.herokuapp.com/delete/$id";

  //call http
  final response = await http
      .delete(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

  if (response.statusCode == 200 || response.statusCode == 204) {
    return print("Deleted");
  } else {
    print("Failed to Delete");
  }
  return print(response.body);
}
