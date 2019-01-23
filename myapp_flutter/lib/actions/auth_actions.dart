import '../models/models.dart';
import '../actions/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String API_KEY = "AIzaSyA7DhuVRtCQSl9cXoLyHc3aWAGOUROzUlA";

class RemoveTokenAction {}

class SetTokenAction {
  final Auth auth;

  SetTokenAction({this.auth});
}

ThunkAction<AppState> tryAuth(
    String email, String password, String authMode, NavigatorState navigator) {
  return (Store<AppState> store) async {
    store.dispatch(StartLoadingAction());
    String url =
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=";
    if (authMode == "login") {
      url =
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=";
    }
    url += API_KEY;
    var client = Client();
    var response = await client.post(
      url,
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
      headers: {
        "Content-Type": "appliaction/json",
      },
    );
    if (response.statusCode != 200) {
      print("Http statusCode: ${response.statusCode}");
    }
    var parsedRes = await jsonDecode(response.body);
    store.dispatch(StopLoadingAction());
    if (parsedRes["idToken"] != null) {
      store.dispatch(storeToken(parsedRes["idToken"], parsedRes["expiresIn"], parsedRes["refreshToken"],));
      navigator.pushReplacementNamed("/mainTabs");
    } else {
      print("Authentication failed, please try again");
    }
  };
}

ThunkAction<AppState> storeToken(String token, String expiresIn String refreshToken) {
  return (Store<AppState> store) async {
    // expiryDate = now + expiresIn
    final DateTime expiryDate = DateTime.now().add(Duration(seconds: int.parse(expiresIn)));
    final Auth auth = Auth(token: token, expiryDate: expiryDate);
    store.dispatch(SetTokenAction(auth: auth));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("myapp:auth:token", token);
    prefs.setString("myapp:auth:expiryDate", expiryDate.toString());
    await prefs.setString("myapp:auth:refreshToken", refreshToken);
  };
}

ThunkAction<AppState> logout(BuildContext context) {
  return (Store<AppState> store) async {
    clearLocalStorage()
    .then((_) {
      store.dispatch(RemoveTokenAction());
      Navigator.pushReplacementNamed(context, "/");
    });
  };
}

Future clearLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Future<bool> resToken = prefs.remove("myapp:auth:token");
  Future<bool> resExpiryDate = prefs.remove("myapp:auth:expiryDate");
  Future<bool> resRefreshToken = prefs.remove("myapp:auth:refreshToken");
  Future.wait([
    resToken,
    resExpiryDate,
    resRefreshToken,
  ])
  .then((_) => print("Succeed"))
  .catchError(() => print("Clear local cache failed!"));
}
