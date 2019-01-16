import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  DefaultInput({this.decoration, this.keyboardType, this.obscureText = false});

  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.all(5),
      child: TextField(
        decoration: decoration,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
