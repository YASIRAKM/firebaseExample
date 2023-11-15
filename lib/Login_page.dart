import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/printPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({super.key});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController _mail=TextEditingController();
  TextEditingController _pswd=TextEditingController();
  Future Authet(mail,pswd)async{
    final ref=await FirebaseAuth.instance;
    final dat=await ref.signInWithEmailAndPassword(email: "$mail", password:"$pswd");
    User? user=dat.user;
    final pref=await SharedPreferences.getInstance();
    final data= await pref.setString("uid", user!.uid);
    if(user != null){
      print("success");
      print(user);
    }
    else{
      print("user not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Form(key:_formkey ,
          child: Column(children: [
            TextFormField(controller: _mail,validator: (value){
              if(value!.isEmpty){
                return 'required';
              }
              return null;
            },),
            TextFormField(controller: _pswd,validator: (value){
              if(value!.isEmpty){
                return 'required';
              }
              return null;
            },),
            ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states){
              if(states.contains(MaterialState.pressed)){
                return Colors.red;
              }
              else{
                return Colors.deepPurpleAccent;
              }
            })),onPressed: (){
              if(_formkey.currentState!.validate()){
               Authet(_mail.text, _pswd.text);
               Navigator.push(context,MaterialPageRoute(builder: (_)=>Printdata()));

              }
            }, child: Text("Login"))

          ],),
        )
    );
  }
}

