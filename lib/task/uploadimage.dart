import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Imageupload extends StatelessWidget {
  double h;
  double w;

  Imageupload({super.key, required this.h, required this.w});

  String selectedvalue = '';
  File? imagefile;
  UploadTask? Up;

  uploadimage1() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    imagefile = File(image!.path);
    var Impath = File(imagefile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$Impath");
    Up = ref.putFile(Impath);
    final cmp = await Up!.whenComplete(() {});
    var Url1 = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    var UID = await db.getString("Id");

    await FirebaseFirestore.instance
        .collection("userdata")
        .add({"url": Url1.toString(), "ID": UID.toString()});
  }

  uploadimagec() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    imagefile = File(image!.path);
    var Impath = File(imagefile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$Impath");
    Up = ref.putFile(Impath);
    final cmp = await Up!.whenComplete(() {});
    var Url1 = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    var UID = await db.getString("Id");

    await FirebaseFirestore.instance
        .collection("userdata")
        .add({"url": Url1.toString(), "ID": UID.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: Column(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {
                            uploadimage1();
                          },
                          child: Text("camera")),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {
                            uploadimagec();
                          },
                          child: Text("gallery"))
                    ],
                  ));
                });
            // uploadimage1();
          },
          child: Container(
            height: h,
            width: w,
            child: Icon(Icons.add, size: 30),
          )),
    );
  }
}
