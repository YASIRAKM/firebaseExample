import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/task/imageview.dart';
import 'package:firebaseexample/task/uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class View1 extends StatefulWidget {
  final UID;

  const View1({super.key, required this.UID});

  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  bool val=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Imageupload(h: 100, w:100,);
            } else if (!snapshot.hasData) {
              return Center(child: Text("no data"));
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  ListTile(title: Imageupload(h: 100, w: 30,),),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10,mainAxisSpacing: 100,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        // if(index==0){
                        //   return Imageupload(h: 100, w: 30,);
                        //
                        // }else{
                        return Wrap(
                          children: [
                            Card(elevation: 20,
                              child: InkWell(onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>imgvw(img1: snapshot.data!.docs[index]['url'].toString(),)));
                              } ,
                                child: Hero(tag:'img' ,
                                  child: Container(height: MediaQuery.of(context).size.height/4,width: MediaQuery.of(context).size.width/3,
                                    child: Image(fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${snapshot.data!.docs[index]["url"]}")),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );},
                      // },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("error"),
              );
            }
          },
          stream: FirebaseFirestore.instance
              .collection("userdata")
              .where("ID", isEqualTo: "${widget.UID.toString()}")
              .snapshots()),
    );
  }
}
