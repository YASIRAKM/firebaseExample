import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imag_uploader extends StatelessWidget {
 double h;
 double w;
 Imag_uploader({required this.h, required this.w});
  UploadTask? uploadTask;
  File? Ima;
  Future<void> Gallery() async{
    var Im=await ImagePicker().pickImage(source: ImageSource.gallery);

    Ima=File(Im!.path);
    var Ims=File(Ima!.path);
    var ref=FirebaseStorage.instance.ref().child("Image/$Ims");
    uploadTask = ref.putFile(Ims);
    final cmp=await  uploadTask!.whenComplete((){

    });
    final url = await cmp.ref.getDownloadURL();
    final db= await FirebaseFirestore.instance.collection("gallery").add({"Image":url});

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(onTap: ()async{

Gallery();

      },child: Container(height:h,width: w,child: Icon(Icons.add,size: 30),)),
    ) ;
  }
}
