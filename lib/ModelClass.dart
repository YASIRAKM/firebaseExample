import 'package:cloud_firestore/cloud_firestore.dart';

class MyModel {
  String? id;
  String name;
  String email;
  String state;
  String place;
  String phone;
  String pin;
  String Url;

  MyModel(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.place,
      required this.pin,
      required this.state,
      required this.Url,
      });

  factory MyModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return MyModel(
        id: document.id,
        name: data!["Name"],
        email: data["E-mail"],
        phone: data["Phone No"],
        place: data['Place'],
        pin: data["Pin"],
        state: data["State"], Url: data["Image"]);
  }
}
