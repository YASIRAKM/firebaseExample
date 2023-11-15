import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseexample/Updatepage.dart';
import 'package:flutter/material.dart';

class singledata extends StatelessWidget {
  final uid;

  singledata({super.key, required this.uid});

  final _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getdata() async {
    var snaps = await _db.collection("Registered_details").doc(this.uid).get();
    var data = snaps.data();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepPurpleAccent,
          elevation: 50,
          child: Column(children: [Icon(Icons.update), Text("Update")]),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => Upd(
                          id: uid,
                        )));
          }),
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.black, Colors.deepPurple]),
            ),
          ),
          title: Text(
            "User Details :",
            style: TextStyle(fontFamily: "font1", fontSize: 30),
          )),
      body: FutureBuilder(
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("has error"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Has No Data "),
              );
            } else if (snapshot.hasData) {
              return Stack(
                children: [
                  Positioned(
                    left: 70,
                    top: 150,
                    child: Card(
                      elevation: 20,
                      child: Container(
                        width: 270,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [Colors.purpleAccent, Colors.deepPurpleAccent])),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text("Name :",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "${snapshot.data!["Name"]}",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "E-mail :",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "${snapshot.data!["E-mail"]}",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text("Phone :",
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text("${snapshot.data!["Phone No"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text("Gender :",
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text("${snapshot.data!["Gender"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text("Place :",
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text("${snapshot.data!["Place"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text("Pin :", style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text("${snapshot.data!["Pin"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text("State :",
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text("${snapshot.data!["State"]}"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  
                ],
              );
            } else {
              return Center(
                child: Text("Error"),
              );
            }
          },
          future: getdata()),
    );
  }
}
