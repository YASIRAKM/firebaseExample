import 'package:firebaseexample/myprovider/mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cntrl extends StatelessWidget {
  const cntrl({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Text("${Provider.of<Mycontroller>(context).counter}"),
            ElevatedButton(onPressed: (){
              Provider.of<Mycontroller>(context,listen: false).incrementCounter();
            }, child: Text("press"))
          ]),
        ),
      ),
    );
  }
}
