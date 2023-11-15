import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_image_upload_button.dart';

class Gaall extends StatefulWidget {
  const Gaall({super.key});

  @override
  State<Gaall> createState() => _GaallState();
}

class _GaallState extends State<Gaall> {
  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width / 4;
    double H = MediaQuery.of(context).size.height / 4;
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("gallery").snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            children: [
              Imag_uploader(
                h: H,
                w: W,
              ),
              CircularProgressIndicator()
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("has error"),
          );
        } else if (!snapshot.hasData) {
          return ListView(
            children: [
              Imag_uploader(
                h: H,
                w: W,
              )
            ],
          );
        } else if (snapshot.hasData) {

          return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
              itemBuilder: (_, index) {
                if(index==0){
                  return Imag_uploader(

                    h: H,
                    w: W,
                  );
                }
                else{
                  return Card(child: Image(image: NetworkImage("${snapshot.data!.docs[index-1].data()["Image"]}")),);
                }
              },
              itemCount: snapshot.data!.docs.length+1 );
        } else {
          return Center(
            child: Text("something went wrong"),
          );
        }
      },
    ));
  }
}
