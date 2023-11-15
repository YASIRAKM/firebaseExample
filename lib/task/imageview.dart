import 'package:flutter/material.dart';

class imgvw extends StatelessWidget {
  const imgvw({super.key, required this.img1});

  final String img1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Hero(tag: 'img', child: Image(image: NetworkImage(img1),))),
    );
  }
}
