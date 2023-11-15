import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/USERS_LIST_2.dart';
import 'package:firebaseexample/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Regp extends StatefulWidget {
  const Regp({super.key});

  @override
  State<Regp> createState() => _RegpState();
}

class _RegpState extends State<Regp> {
  GlobalKey<FormState> formk = GlobalKey<FormState>();
  TextEditingController _cname = TextEditingController();
  TextEditingController _cphone = TextEditingController();
  TextEditingController _cmail = TextEditingController();
  TextEditingController _cplace = TextEditingController();
  TextEditingController _cpin = TextEditingController();
  TextEditingController _cstate = TextEditingController();
  TextEditingController _cpswd = TextEditingController();
  String _gender = "male";
  bool _isvisible = false;
  UploadTask? U1;

  void Radiochange(value) {
    setState(() {
      _gender = value;
    });
  }

  File? Image_file;

  Future<void> pickimage() async {
    var Images = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      Image_file = File(Images!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Registered_details")
              .snapshots(),
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
                child: Text("No Data"),
              );
            } else if (snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    height: 800,
                    width: 400,
                    child: Image(
                      image: NetworkImage("https://t.ly/gxoYH"),
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  Positioned(
                      top: -950,
                      left: 90,
                      child: Text(
                        "WELCOME",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "font1",
                            height: 50,
                            color: Colors.white),
                      )),
                  Positioned(
                      top: -310,
                      left: 120,
                      child: Text(
                        "Register here:",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "font3",
                            height: 40,
                            color: Colors.white),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 150, left: 28, right: 28),
                    child: ListView(
                      children: [
                        Form(
                            key: formk,
                            child: Column(
                              children: [
                                NewWidget(
                                  cname: _cname,
                                  mylabel: 'Name',
                                  myIcon: Icons.person,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                NewWidget(
                                    cname: _cphone,
                                    myIcon: Icons.phone,
                                    mylabel: 'Phone'),
                                SizedBox(
                                  height: 10,
                                ),
                                NewWidget(
                                    cname: _cmail,
                                    myIcon: Icons.mail,
                                    mylabel: 'E-mail'),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    RadioMenuButton(
                                        value: "male",
                                        groupValue: _gender,
                                        onChanged: Radiochange,
                                        child: Text(
                                          "MALE",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    RadioMenuButton(
                                        value: "female",
                                        groupValue: _gender,
                                        onChanged: Radiochange,
                                        child: Text(
                                          "FEMALE",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    RadioMenuButton(
                                        value: "others",
                                        groupValue: _gender,
                                        onChanged: Radiochange,
                                        child: Text(
                                          "OTHERS",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                NewWidget(
                                    cname: _cplace,
                                    myIcon: Icons.place,
                                    mylabel: 'Place'),
                                SizedBox(
                                  height: 10,
                                ),
                                NewWidget(
                                    cname: _cpin,
                                    myIcon: Icons.pin_drop,
                                    mylabel: 'Pin'),
                                SizedBox(
                                  height: 10,
                                ),
                                NewWidget(
                                    cname: _cstate,
                                    myIcon: Icons.terrain_rounded,
                                    mylabel: 'State'),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  obscureText: !_isvisible,
                                  obscuringCharacter: '*',
                                  controller: _cpswd,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "pleaefill";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isvisible = !_isvisible;
                                            });
                                          },
                                          icon: Icon(_isvisible
                                              ? CupertinoIcons.eye_solid
                                              : CupertinoIcons.eye_slash_fill)),
                                      labelText: "Passwrd",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Colors.white,
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  onTap: () {
                                    pickimage();
                                  },
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  leading:
                                      Icon(Icons.image, color: Colors.white),
                                  title: Text(
                                    "Upload Image",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Image_file == null
                                      ? Text(
                                          "No image",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(
                                            image: FileImage(Image_file!),
                                          ),
                                        ),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.transparent)),
                                    onPressed: () async {
                                      final refs = await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _cmail.text,
                                              password: _cpswd.text);
                                      User? user = refs.user;
                                      if (user != null) {
                                        if (Image_file == null) {
                                          Fluttertoast.showToast(
                                              msg: "PICK IMAGE",
                                              gravity:
                                                  ToastGravity.CENTER_RIGHT);
                                        } else {
                                          if (formk.currentState!.validate()) {
                                            var FILE_path =
                                                File(Image_file!.path);
                                            var Str = FirebaseStorage.instance
                                                .ref()
                                                .child("UserImage/$FILE_path");
                                            U1 = Str.putFile(FILE_path);
                                            var chek =
                                                await U1!.whenComplete(() {});
                                            var Url =
                                                await chek.ref.getDownloadURL();
                                            FirebaseFirestore inst =
                                                await FirebaseFirestore
                                                    .instance;
                                            inst
                                                .collection("User_Details")
                                                .add({
                                              "Name": "${_cname.text}",
                                              "Phone No": "${_cphone.text}",
                                              "E-mail": "${_cmail.text}",
                                              "Gender": "$_gender",
                                              "Place": "${_cplace.text}",
                                              "Pin": "${_cpin.text}",
                                              "Password": "${_cpswd.text}",
                                              "State": "${_cstate.text}",
                                              "Image": Url
                                            });

                                            Fluttertoast.showToast(
                                                msg: "DONE",
                                                gravity:
                                                    ToastGravity.BOTTOM_RIGHT);
                                            _cstate.clear();
                                            _cpin.clear();
                                            _cplace.clear();
                                            _cmail.clear();
                                            _cphone.clear();
                                            _cname.clear();
                                            _cpswd.clear();
                                            setState(() {
                                              Image_file = null;
                                            });
                                          }
                                        }
                                      } else {
                                        print(
                                            "add correct type email and password");
                                      }
                                    },
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.transparent)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Userli()));
                                    },
                                    child: Text(
                                      "Users",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text("ERROR"),
              );
            }
          }),
    );
  }
}
