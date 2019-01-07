import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(fit: StackFit.expand, children: <Widget>[
      new Image(
          image: new AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover),
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      )
    ]));
  }
}
