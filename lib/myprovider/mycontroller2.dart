import 'package:flutter/material.dart';

class Mycontroller2 extends ChangeNotifier{
  int decounter=0;

  void decrement(){
    decounter--;
    notifyListeners();
  }
}