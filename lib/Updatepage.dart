import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Upd extends StatelessWidget {
  final id;

  Upd({super.key, required this.id});

  TextEditingController cname = TextEditingController();
  TextEditingController cphone = TextEditingController();
  TextEditingController cmail = TextEditingController();
  TextEditingController cplace = TextEditingController();
  TextEditingController cpin = TextEditingController();
  TextEditingController cstate = TextEditingController();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Colors.blue]),
          ),
        ),
        title: Text("Update Details",
            style: TextStyle(fontFamily: "font2", fontSize: 20)),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 80, left: 20, right: 30),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.blue,Colors.yellow]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cname,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({"Name": "${cname.text}"});
                        },
                        icon: Icon(Icons.update)),
                    labelText: "Name"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[ Colors.blue,Colors.yellow]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cmail,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({
                            "E-mail": "${cmail.text}",
                          });
                        },
                        icon: Icon(Icons.update)),
                    labelText: "E-mail"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[ Colors.blue,Colors.yellow]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cphone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({
                            "Phone No": "${cphone.text}",
                          });
                        },
                        icon: Icon(Icons.update)),
                    labelText: "Phone"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[ Colors.blue,Colors.yellow]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cplace,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({
                            "Place": "${cplace.text}",
                          });
                        },
                        icon: Icon(Icons.update)),
                    labelText: "Place"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[ Colors.blue,
                      Colors.yellow,]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cpin,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({
                            "Pin": "${cpin.text}",
                          });
                        },
                        icon: Icon(Icons.update)),
                    labelText: "Pin"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.blue,
                      Colors.yellow,
                    ]),
              ),
              width: 200,
              height: 50,
              child: TextField(
                controller: cstate,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _db
                              .collection("Registered_details")
                              .doc(id)
                              .update({"State": "${cstate.text}"});
                        },
                        icon: Icon(Icons.update)),
                    labelText: "State"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Update Complete")),
          )
        ],
      ),
    );
  }
}
