import 'package:flutter/material.dart';
import '../../widgets/ui/primary_button.dart';
import '../../widgets/ui/default_input.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String authMode = "login";
  String _email = "";
  String _password = "";

  void authHandler() {
    Navigator.pushReplacementNamed(context, "/mainTabs");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Image(
          image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: <Widget>[
                  Text(
                    "Please Log In",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  PrimaryButton(
                      text: "Switch to Sign Up", onPressed: () => print("!!!")),
                  DefaultInput(
                    decoration:
                        InputDecoration(hintText: "Your E-Mail Address"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  DefaultInput(
                    decoration: InputDecoration(hintText: "Password"),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                  PrimaryButton(
                    text: "Submit",
                    onPressed: authHandler,
                  )
                ],
              ),
            ),
          )
        ],
      )
    ]));
  }
}
