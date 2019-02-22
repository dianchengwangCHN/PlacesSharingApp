import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final String value;
  final bool valid;
  final bool touched;
  final Function onChanged;

  DefaultInput({
    this.decoration,
    this.keyboardType,
    this.obscureText = false,
    this.value = "",
    this.valid = false,
    this.touched = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: TextField(
        decoration: valid || !touched
            ? decoration
            : decoration.copyWith(
                fillColor: Colors.red[100],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
              ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
