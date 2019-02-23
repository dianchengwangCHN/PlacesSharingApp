import 'package:flutter/material.dart';
import '../../widgets/ui/primary_button.dart';
import '../../widgets/ui/default_input.dart';
import '../../models/models.dart';
import '../../utils/validators.dart';

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

  ItemInfo _email;
  ItemInfo _password;
  ItemInfo _confirmPassword;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      widget.onAutoSignIn(context);
    }

    _authMode = "login";
    _email = ItemInfo();
    _password = ItemInfo();
    _confirmPassword = ItemInfo();
  }

  void switchAuthModeHandler() {
    setState(() {
      _authMode = _authMode == "login" ? "signup" : "login";
    });
  }

  void updateInfoHandler(String key, String val) {
    ItemInfo target;
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
      target.touched = true;
      if (key == "email") {
        target.valid = isEmailValidator(val);
      } else if (key == "password") {
        target.valid = minLenValidator(val, 6);
      } else if (key == "confirmPassword") {
        target.valid = equalToValidator(val, _password.value);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget confirmPasswordInput = Container();
    Widget submmitButton = widget.isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          )
        : PrimaryButton(
            text: "Submit",
            onPressed: !_email.valid ||
                    !_password.valid ||
                    (_authMode == "signup" && !_confirmPassword.valid)
                ? null
                : () {
                    widget.onTryAuth(
                        _email.value, _password.value, _authMode, context);
                  },
          );

    if (_authMode == "signup") {
      confirmPasswordInput = DefaultInput(
        decoration: InputDecoration(
          hintText: "Confirm Password",
        ),
        valid: _confirmPassword.valid,
        touched: _confirmPassword.touched,
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
                    valid: _email.valid,
                    touched: _email.touched,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String val) => updateInfoHandler("email", val),
                  ),
                  DefaultInput(
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    valid: _password.valid,
                    touched: _password.touched,
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
