import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseexample/Update2.dart';
import 'package:flutter/material.dart';

class Sin extends StatelessWidget {
  final UID;

  Sin({super.key, required this.UID});

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: db.collection("User_Details").doc(this.UID).snapshots(),
      builder: (context, snapshot) {
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
                  top: 60,
                  left: 120,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("${snapshot.data!["Image"]}"),
                    radius: 70,
                  )),
              Positioned(
                  top: 220,
                  child: Container(
                    width: 395,
                    height: 800,
                    // child: Image(
                    //     image: NetworkImage("https://rb.gy/am1bg"),
                    //     fit: BoxFit.fill),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://rb.gy/e0w8h"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  )),
              Positioned(bottom: 30,right:125,
                child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Update2(Id: snapshot.data!.id,)));
                }, child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 20,),
                    Text("UPDATE"),
                  ],
                )),
              ),
              Positioned(
                top: 220,
                left: 60,
                child: Container(
                  width: 278,
                  height: 450,
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Column(children: [
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: Text("Name:", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["Name"]}",
                            style:
                                TextStyle(fontSize: 20, fontFamily: "font1",color: Colors.black)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading:
                            Text("Phone :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["Phone No"]}",
                            style:
                                TextStyle(fontSize: 20, fontFamily: "font1")),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: Text("Mail :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["E-mail"]}",
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading:
                            Text("Gender :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["Gender"]}",
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading:
                            Text("Place :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["Place"]}",
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: Text("Pin :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["Pin"]}",
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading:
                            Text("State :", style: TextStyle(fontSize: 18)),
                        title: Text("${snapshot.data!["State"]}",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          );
        } else {
          return Text("error");
        }
      },
    ));
  }
}
