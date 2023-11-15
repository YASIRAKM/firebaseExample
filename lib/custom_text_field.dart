import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required TextEditingController cname,
    required this.myIcon,
    required this.mylabel,
  }) : _cname = cname;

  final TextEditingController _cname;
  final IconData myIcon;
  final String mylabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _cname,
      decoration: InputDecoration(
          prefixIcon: Icon(myIcon,color: Colors.white),
          labelText: mylabel,
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      validator: (v) {
        if (v!.isEmpty) {
          return "PLEASE FILL";
        }
        return null;
      },
    );
  }
}
