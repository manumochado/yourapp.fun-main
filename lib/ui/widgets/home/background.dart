import 'package:flutter/material.dart';

getBackGround() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Image(
      image: AssetImage('assets/Ref1/Fondo.png'),
      fit: BoxFit.fill,
    ),
  );
}
