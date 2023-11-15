import 'package:flutter/material.dart';

class Mycontroller extends ChangeNotifier{
  int counter = 0;

  void incrementCounter(){
    counter++;
    notifyListeners();
  }
}
