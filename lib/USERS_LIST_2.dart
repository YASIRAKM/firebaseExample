import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseexample/ModelClass.dart';
import 'package:firebaseexample/Single2.dart';
import 'package:flutter/material.dart';

class Userli extends StatefulWidget {
  const Userli({super.key});

  @override
  State<Userli> createState() => _UserliState();
}

class _UserliState extends State<Userli> {
  final Ins = FirebaseFirestore.instance;

  Future<List<MyModel>> getdata() async {
    final snap = await Ins.collection("User_Details").get();
    final userd = snap.docs.map((e) => MyModel.fromDocument(e)).toList();
    return userd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
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
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image(
                        image: NetworkImage("https://t.ly/_hIWU"),
                        fit: BoxFit.fill),
                  ),
                  Positioned(
                      top: 40,
                      left: 130,
                      child: Text("Users",
                          style: TextStyle(fontFamily: "font2", fontSize: 50))),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Sin(
                                                UID:
                                                    "${snapshot.data![index].id}",
                                              )));
                                });
                              },
                              leading: Image(
                                  height: 80,
                                  image: NetworkImage(
                                      "${snapshot.data![index].Url}")),
                              title: Text("${snapshot.data![index].name}"),
                              subtitle: Text("${snapshot.data![index].email}"),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await Ins.collection("User_Details")
                                        .doc("${snapshot.data![index].id}")
                                        .delete();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("error"),
              );
            }
          }),
    );
  }
}
