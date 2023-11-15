import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/ModelClass.dart';
import 'package:firebaseexample/printPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  GlobalKey<FormState> formk = GlobalKey<FormState>();
  TextEditingController _cname = TextEditingController();
  TextEditingController _cphone = TextEditingController();
  TextEditingController _cmail = TextEditingController();
  TextEditingController _cplace = TextEditingController();
  TextEditingController _cpin = TextEditingController();
  TextEditingController _cstate = TextEditingController();
  String _gender = "male";
UploadTask? upload;
  void Radiochange(value) {
    setState(() {
      _gender = value;
    });
  }

  File? Ims;

  Future<void> pickimage() async {
    var Ima = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      Ims = File(Ima!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text("Registration :",
              style: TextStyle(
                  fontSize: 30, fontFamily: "font1", color: Colors.white)),
          elevation: 30,
          leading: Icon(Icons.app_registration, color: Colors.white)),
      body: Stack(
        children: [
          Container(),
          Positioned(
            top: 100,
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                height: 550,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.7],
                    )),
                child: Form(
                    key: formk,
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _cname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          controller: _cphone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Phone No",
                            prefixIcon: Icon(Icons.call),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        TextFormField(
                          controller: _cmail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.mail),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                              Text("Gender:", style: TextStyle(fontSize: 18)),
                        ),
                        Row(
                          children: [
                            RadioMenuButton(
                                value: "male",
                                groupValue: _gender,
                                onChanged: Radiochange,
                                child: Text("MALE")),
                            RadioMenuButton(
                                value: "female",
                                groupValue: _gender,
                                onChanged: Radiochange,
                                child: Text("FEMALE")),
                            RadioMenuButton(
                                value: "others",
                                groupValue: _gender,
                                onChanged: Radiochange,
                                child: Text("OTHERS")),
                          ],
                        ),
                        TextFormField(
                          controller: _cplace,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Place",
                            prefixIcon: Icon(Icons.place),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          controller: _cpin,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Pin",
                            prefixIcon: Icon(Icons.pin_drop),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: _cstate,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "State",
                            prefixIcon: Icon(Icons.terrain_sharp),
                            border: InputBorder.none,
                          ),
                        ),
                        ListTile(
                            leading: Ims == null
                                ? Text("No image")
                                : SizedBox(
                                    width: 60,
                                    height: 30,
                              child: Image(image: FileImage(Ims!),),
                                  ),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  pickimage();
                                },
                                child: Icon(Icons.image))),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.purple[200])),
                            onPressed: () async{
                              if (Ims == null) {
                                Fluttertoast.showToast(msg: "ADD Image");
                              } else {
                                if (formk.currentState!.validate()) {
                                  var IM=File(Ims!.path);
                                  var str= FirebaseStorage.instance.ref().child("Userimages/$IM");
                                  upload=str.putFile(IM);
                                  var chk=await upload!.whenComplete(() => null);
                                  var url=await chk.ref.getDownloadURL();
                                  FirebaseFirestore ins =
                                      await FirebaseFirestore.instance;

                                  ins.collection("Registered_details").add({
                                    "Name": "${_cname.text}",
                                    "Phone No": "${_cphone.text}",
                                    "E-mail": "${_cmail.text}",
                                    "Gender": "$_gender",
                                    "Place": "${_cplace.text}",
                                    "Pin": "${_cpin.text}",
                                    "State": "${_cstate.text}",
                                    "Image": url
                                  });
                                  Fluttertoast.showToast(
                                      msg: "DONE",
                                      gravity: ToastGravity.BOTTOM_RIGHT);
                                  _cstate.clear();
                                  _cpin.clear();
                                  _cplace.clear();
                                  _cmail.clear();
                                  _cphone.clear();
                                  _cname.clear();
                                  setState(() {
                                    Ims=null;
                                  });

                                }
                              }
                            },
                            child: Text(
                              "SUBMIT",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Printdata()));
                            },
                            child: Text(
                              "USERS",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ))
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
