import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  File?  img;
  Future getimg()async{
    var ImageS=await  ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      img=File(ImageS!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: getimg, child: Text("Click")),
              ElevatedButton(onPressed:()async{
               var img1=File(img!.path);
                var ref=FirebaseStorage.instance.ref().child("Image/img");
                 ref.putFile(img1);
              } , child: Text("Upload")),
            ],
          ),
        ),
      ),
    );
  }
}
