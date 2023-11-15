import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/Gallery.dart';
import 'package:firebaseexample/Login_page.dart';
import 'package:firebaseexample/myprovider/mycontroller.dart';
import 'package:firebaseexample/myprovider/viewpage.dart';

import 'package:firebaseexample/signup_page.dart';
import 'package:firebaseexample/Page2.dart';
import 'package:firebaseexample/Reg2.dart';
import 'package:firebaseexample/Registration_Page.dart';
import 'package:firebaseexample/USERS_LIST_2.dart';
import 'package:firebaseexample/ViewPage.dart';
import 'package:firebaseexample/task/Registrationpage.dart';
import 'package:firebaseexample/task/uploadimage.dart';
import 'package:firebaseexample/task/viewpage.dart';
import 'package:firebaseexample/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider(
      create: (BuildContext context)  =>Mycontroller(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Colors.purple,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Reg1()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [ElevatedButton(onPressed: (){
          FirebaseFirestore ins=FirebaseFirestore.instance;
          ins.collection("user").add({"name":"bcmkdk","age":"55"});
        }, child: Text("click"))]),
      ),
    );
  }
}
