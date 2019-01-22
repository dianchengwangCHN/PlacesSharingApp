import '../models/models.dart';
import '../actions/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

const String API_KEY = "AIzaSyA7DhuVRtCQSl9cXoLyHc3aWAGOUROzUlA";

class AuthRemoveTokenAction {}

class AuthSetTokenAction {
  final Auth auth;

  AuthSetTokenAction({this.auth});
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
      }),
      headers: {
        "Content-Type": "appliaction/json",
      },
    );
    var parsedRes = await jsonDecode(response.body);
    store.dispatch(StopLoadingAction());
    navigator.pushReplacementNamed("/mainTabs");
  };
}
