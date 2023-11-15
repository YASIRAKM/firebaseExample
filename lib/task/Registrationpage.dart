import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/custom_image_upload_button.dart';
import 'package:firebaseexample/task/uploadimage.dart';
import 'package:firebaseexample/task/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reg1 extends StatefulWidget {
  const Reg1({super.key});

  @override
  State<Reg1> createState() => _Reg1State();
}

class _Reg1State extends State<Reg1> {
  GlobalKey<FormState> form1 = GlobalKey<FormState>();
  TextEditingController namec = TextEditingController();
  TextEditingController mailc = TextEditingController();
  TextEditingController passwrdc = TextEditingController();
  bool login = false;

  usercreate(mail, passwrd, name) async {
    try {
      final ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: passwrd);
      User? user = ref.user;
      if (user != null) {
        var ref = await FirebaseFirestore.instance
            .collection("userd")
            .add({'name': name, 'email': mail, 'password': passwrd});
        var refs = await SharedPreferences.getInstance();
        await refs.setString("Id", user.uid);
      } else {
        return 'error';
      }
      Fluttertoast.showToast(msg: "success");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "email already exist");
      }
      if (e.code == "invalid-email") {
        Fluttertoast.showToast(msg: "Invalid email format");
      }
      if (e.code == "weak-password") {
        Fluttertoast.showToast(msg: "Weak password");
      } else {
        Fluttertoast.showToast(msg: "authentication error");
      }
    }
  }

  signup(mail, passwrd) async {
    try {
      if (login) {
        final ref = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mail, password: passwrd);
        User? user = ref.user;
        if (user != null) {
          final pref = await SharedPreferences.getInstance();
          final cn = await pref.getString("Id");
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => View1(UID: cn.toString())));
        } else {
          return 'error';
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-email") {
        Fluttertoast.showToast(msg: 'Invalid email format');
      }
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        Fluttertoast.showToast(msg: "email or password is wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            !login
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://rb.gy/fsfpf"),
                            fit: BoxFit.fill)),
                  )
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://rb.gy/470ek"),
                            fit: BoxFit.fill)),
                  ),
            !login
                ? Positioned(
                    left: 80,
                    top: 100,
                    child: Text(
                      "Welcome",
                      style: GoogleFonts.racingSansOne(fontSize: 50),
                    ))
                : Positioned(
                    top: 120,
                    left: 40,
                    child: Text(
                      "Welcome Back!",
                      style:
                          GoogleFonts.actor(fontSize: 50, color: Colors.black),
                    )),
            Form(
                key: form1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!login)
                        txtfrf(
                          cntrl: namec,
                          icndt: Icons.person,
                          lbl: 'Name',
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      txtfrf(
                        cntrl: mailc,
                        icndt: Icons.mail,
                        lbl: 'Mail',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      txtfrf(
                        cntrl: passwrdc,
                        icndt: Icons.password,
                        lbl: 'Password',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !login
                          ? ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.teal;
                                  }
                                  else{
                                    return Colors.transparent;
                                  }
                                }),elevation: MaterialStatePropertyAll(0)
                              ),
                              onPressed: () {
                                if (form1.currentState!.validate()) {
                                  usercreate(
                                      mailc.text, passwrdc.text, namec.text);
                                  mailc.clear();
                                  namec.clear();
                                  passwrdc.clear();
                                }
                              },
                              child: Text("Create"))
                          : ElevatedButton(
                              style: ButtonStyle(elevation: MaterialStatePropertyAll(0),backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.purpleAccent;
                                } else {
                                  return Colors.transparent;
                                }
                              })),
                              onPressed: () async {
                                if (form1.currentState!.validate()) {
                                  signup(mailc.text, passwrdc.text);
                                  mailc.clear();
                                  passwrdc.clear();
                                }
                              },
                              child: Text("Sign up")),
                      !login
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  login = !login;
                                });
                              },
                              child: Text(
                                "ALREADY A USER",
                                style: GoogleFonts.abrilFatface(
                                    color: Colors.black, fontSize: 18),
                              ))
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  login = !login;
                                });
                              },
                              child: Text("NOT A USER",
                                  style: GoogleFonts.abrilFatface(
                                      color: Colors.black, fontSize: 18)))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class txtfrf extends StatelessWidget {
  var cntrl;
  IconData icndt;
  String lbl;

  txtfrf(
      {super.key, required this.cntrl, required this.icndt, required this.lbl});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cntrl,
      decoration: InputDecoration(
          prefixIcon: Icon(icndt),
          labelText: lbl,
          labelStyle: GoogleFonts.roboto(fontSize: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'fill';
        }
        return null;
      },
    );
  }
}
