import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  GlobalKey<FormState> formk = GlobalKey<FormState>();
  TextEditingController _cname = TextEditingController();
  TextEditingController _cphone = TextEditingController();
  TextEditingController _cmail = TextEditingController();
  TextEditingController _cplace = TextEditingController();
  TextEditingController _cpin = TextEditingController();
  TextEditingController _cstate = TextEditingController();
  String _gender = "male";
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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                            key: formk,
                            child: Column(
                              children: [
                                NewWidget(
                                  cname: _cname,
                                  mylabel: 'Name',
                                  myIcon: Icons.person,
                                ),
                                SizedBox(height: 20),
                                NewWidget(
                                    cname: _cphone,
                                    myIcon: Icons.phone,
                                    mylabel: 'Phone'),
                                NewWidget(
                                    cname: _cmail,
                                    myIcon: Icons.mail,
                                    mylabel: 'E-mail'),
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
                                NewWidget(
                                    cname: _cplace,
                                    myIcon: Icons.place,
                                    mylabel: 'Place'),
                                NewWidget(
                                    cname: _cpin,
                                    myIcon: Icons.pin_drop,
                                    mylabel: 'Pin'),
                                NewWidget(
                                    cname: _cstate,
                                    myIcon: Icons.terrain_rounded,
                                    mylabel: 'State'),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: ElevatedButton(
                                      onPressed: () {
                                        pickimage();
                                      },
                                      child: Text("Upload Image")),
                                  trailing: Image_file == null
                                      ? Text("No image")
                                      : SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(
                                            image: FileImage(Image_file!),
                                          ),
                                        ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (Image_file == null) {
                                        Fluttertoast.showToast(
                                            msg: "PICK IMAGE",
                                            gravity: ToastGravity.CENTER_RIGHT);
                                      } else {
                                        if (formk.currentState!.validate()) {
                                          var FILE_path = File(Image_file!.path);
                                          var Str = FirebaseStorage.instance
                                              .ref()
                                              .child("UserImage/$FILE_path");
                                          U1 = Str.putFile(FILE_path);
                                          var chek = await U1!.whenComplete(() {});
                                          var Url = await chek.ref.getDownloadURL();
                                          FirebaseFirestore inst =
                                              await FirebaseFirestore.instance;
                                          inst.collection("User_Details").add({
                                            "Name": "${_cname.text}",
                                            "Phone No": "${_cphone.text}",
                                            "E-mail": "${_cmail.text}",
                                            "Gender": "$_gender",
                                            "Place": "${_cplace.text}",
                                            "Pin": "${_cpin.text}",
                                            "State": "${_cstate.text}",
                                            "Image": Url
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
                                            Image_file = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Text("SUBMIT"))
                              ],
                            )),
                      ),
                    ],
                  );
                });
          } else {
            return Text("ERROR");
          }
        },
        stream: FirebaseFirestore.instance
            .collection("Registered_details")
            .snapshots(),
      ),
    );
  }
}
