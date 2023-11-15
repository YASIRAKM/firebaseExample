import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update2 extends StatelessWidget {
  final Id;
   Update2({super.key,required this.Id});
  TextEditingController cname = TextEditingController();
  TextEditingController cphone = TextEditingController();
  TextEditingController cmail = TextEditingController();
  TextEditingController cplace = TextEditingController();
  TextEditingController cpin = TextEditingController();
  TextEditingController cstate = TextEditingController();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(decoration:BoxDecoration(color: Colors.yellow) ),
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 20,right: 20),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              textfields(name: cname, myIcon: Icons.person, mylabel: 'Name'),
              textfields(name: cphone, myIcon: Icons.call, mylabel: 'Phone'),
              textfields(name: cmail, myIcon: Icons.mail, mylabel: 'Mail'),
              textfields(name: cplace, myIcon: Icons.place_outlined, mylabel: 'Place'),
              textfields(name: cpin, myIcon: Icons.pin_drop_outlined, mylabel: 'Pin'),
              textfields(name: cstate, myIcon: Icons.map_outlined, mylabel: 'State'),
              ElevatedButton(onPressed: ()async{
                _db.collection("").doc(Id).update({"Name":"${cname.text}",
                });
              }, child: Text("UPDATE"))
            ],),
          ),
        ],
      )
    );
  }
}

class textfields extends StatelessWidget {
  final TextEditingController name;
  final IconData myIcon;
  final String mylabel;
   textfields({
    super.key, required this.name, required this.myIcon, required this.mylabel,
  });

  @override

  Widget build(BuildContext context) {
    return TextField(
      controller: name,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),prefixIcon: Icon(myIcon),labelText: mylabel),
    );
  }
}
