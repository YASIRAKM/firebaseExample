import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vwpage extends StatefulWidget {
  const Vwpage({super.key});

  @override
  State<Vwpage> createState() => _VwpageState();
}

class _VwpageState extends State<Vwpage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Registered_details").snapshots(), builder: (context , snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      else if(snapshot.hasError){
        return Center(child: Text("Has error"),);
      }
      else if(!snapshot.hasData){
        return Center(child: Text("Has no data"),);
      }
      else if(snapshot.hasData){
        List<QueryDocumentSnapshot> document=snapshot.data!.docs;
       return ListView.builder(itemBuilder: (_,index){
        return Text("${snapshot.data!.docs[index].data()["Name"]}");
       },itemCount: document.length,);
      }
      else{
        return Center(child: Text("error"));
      }

    }),);
  }
}
