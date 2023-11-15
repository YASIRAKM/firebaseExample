import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ModelClass.dart';
import 'singleprintpage.dart';

class Printdata extends StatefulWidget {
  const Printdata({super.key});

  @override
  State<Printdata> createState() => _PrintdataState();
}

class _PrintdataState extends State<Printdata> {
  final _db = FirebaseFirestore.instance;

  Future<List<MyModel>> getdata() async {
    final snaps = await _db.collection("Registered_details").get();
    final userdata =
        snaps.docs.map((element) => MyModel.fromDocument(element)).toList();
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
      "USERS :",
      style: TextStyle( fontSize: 50,fontFamily: "font1"),

    ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.red, Colors.white]),
        ),
      ),
    ),


      body: FutureBuilder<List<MyModel>>(
          future: getdata(),
          builder: (context, AsyncSnapshot<List<MyModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Has no data"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (_, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30,left: 8.0,right: 8.0),
                      child: Container(
                        width: 350,
                        height: 80,
                        child: Card(
                          elevation: 25,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(colors: [
                                  Colors.lightBlueAccent,
                                  CupertinoColors.systemYellow,
                                  Colors.teal
                                ])),
                            child: ListTile(
                              leading: IconButton(
                                  onPressed: () async {
                                    await _db
                                        .collection("Registered_details")
                                        .doc("${snapshot.data![index].id}")
                                        .delete();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                              onTap: () {


                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => singledata(
                                              uid: snapshot.data?[index].id)));
                                });
                              },
                              title: Text("${snapshot.data![index].name}",
                                  style: TextStyle(fontSize: 20)),
                              subtitle: Text("${snapshot.data![index].email}",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length);
            } else {
              return Center(
                child: Text("ERROR"),
              );
            }
          }),
    );
  }
}
