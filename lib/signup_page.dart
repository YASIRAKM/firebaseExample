import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyAuth extends StatefulWidget {
  const MyAuth({super.key});

  @override
  State<MyAuth> createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  TextEditingController _mail=TextEditingController();
  TextEditingController _pswd=TextEditingController();
  Future Authe(mail,pswd)async{
    final ref=await FirebaseAuth.instance;
    ref.createUserWithEmailAndPassword(email: "$mail", password:"$pswd");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
     Column(children: [
       TextFormField(controller: _mail,),
       TextFormField(controller: _pswd,),
       ElevatedButton(onPressed: (){
         Authe(_mail.text, _pswd.text);
       }, child: Text("Sign Up"))

     ],)
    );
  }
}
