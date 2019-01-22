import 'package:flutter/material.dart';
import '../../widgets/ui/primary_button.dart';
import '../../widgets/ui/default_input.dart';
import '../../models/auth_info.dart';

class AuthPage extends StatefulWidget {
  final bool isLoading;
  final Function onTryAuth;
  final Function onAutoSignIn;

  AuthPage({
    this.isLoading,
    this.onTryAuth,
    this.onAutoSignIn,
  });

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _authMode;

  AuthInfo _email;
  AuthInfo _password;
  AuthInfo _confirmPassword;

  @override
  void initState() {
    super.initState();
    _authMode = "login";
    _email = AuthInfo();
    _password = AuthInfo();
    _confirmPassword = AuthInfo();
  }

  void switchAuthModeHandler() {
    setState(() {
      _authMode = _authMode == "login" ? "signup" : "login";
    });
  }

  void updateInfoHandler(String key, String val) {
    AuthInfo target;
    if (key == "email") {
      target = _email;
    } else if (key == "password") {
      target = _password;
    } else if (key == "confirmPassword") {
      target = _confirmPassword;
    } else {
      return;
    }
    setState(() {
      target.value = val;
      target.valid = true;
      target.touched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget confirmPasswordInput = Container();
    Widget submmitButton = PrimaryButton(
      text: "Submit",
      onPressed: () {
        widget.onTryAuth(
            _email.value, _password.value, _authMode, Navigator.of(context));
      },
    );

    if (_authMode == "signup") {
      confirmPasswordInput = DefaultInput(
        decoration: InputDecoration(
          hintText: "Confirm Password",
        ),
        obscureText: true,
        keyboardType: TextInputType.text,
        onChanged: (String val) => updateInfoHandler("confirmPassword", val),
      );
    }

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
                    "Please ${_authMode == "login" ? "Log In" : "Sign Up"}",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  PrimaryButton(
                    text:
                        "Switch to ${_authMode == "login" ? "Sign Up" : "Login"}",
                    onPressed: switchAuthModeHandler,
                  ),
                  DefaultInput(
                    decoration: InputDecoration(
                      hintText: "Your E-Mail Address",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String val) => updateInfoHandler("email", val),
                  ),
                  DefaultInput(
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (String val) =>
                        updateInfoHandler("password", val),
                  ),
                  confirmPasswordInput,
                  submmitButton,
                ],
              ),
            ),
          )
        ],
      )
    ]));
  }
}
