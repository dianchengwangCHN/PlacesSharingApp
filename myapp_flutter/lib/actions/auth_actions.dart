import '../models/models.dart';
import '../actions/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart';
import 'dart:async';
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
    String email, String password, String authMode, BuildContext context) {
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
      Navigator.pushReplacementNamed(context, "/mainTabs");
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
    Future<bool> tokenStored = prefs.setString("myapp:auth:token", token);
    Future<bool> expiryDateStored = prefs.setString("myapp:auth:expiryDate", expiryDate.toString());
    Future<bool> refreshTokenStored = prefs.setString("myapp:auth:refreshToken", refreshToken);
    Future.wait([
      tokenStored,
      expiryDateStored,
      refreshTokenStored,
    ])
    .then((_) => print("Storing to local succeeded"))
    .catchError(() => print("Storing to local failed"));
  };
}

ThunkAction<AppState> autoSignIn(BuildContext context) {
  return (Store<AppState> store) async {
    getToken(store)
    .then((_) => Navigator.pushReplacementNamed(context, "/mainTabs"))
    .catchError(() => print("Failed to fetch token!"));
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

Future<String> getToken(Store<AppState> store) async {
  String token = store.state.auth.token;
  DateTime expiryDate = store.state.auth.expiryDate;
  if (token != null && expiryDate.isAfter(DateTime.now())) {
    return Future.value(token);
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String localToken = prefs.getString("myapp:auth:token");
  if (localToken != null) {
    DateTime localExpiryDate = DateTime.parse(prefs.getString("myapp:auth:expiryDate"));
    if (localExpiryDate.isAfter(DateTime.now())) {
      store.dispatch(SetTokenAction(
        auth: Auth(
          token: localToken, 
          expiryDate: localExpiryDate,
        ),
      ));
      return Future.value(localToken);
    }
  } else {
    return Future.error("No token stored");
  }
  String refreshToken = prefs.getString("myapp:auth:refreshToken");
  var client = Client();
  String url = "https://securetoken.googleapis.com/v1/token?key=";
  var response = await client.post(
    url + API_KEY,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: "grant_type=refresh_token&refresh_token=$refreshToken",
  );
  if (response.statusCode != 200) {
    return Future.error("Refresh token failed");
  }
  var parsedRes = jsonDecode(response.body);
  if (parsedRes["id_token"] != null) {
    store.dispatch(storeToken(
      parsedRes["id_token"],
      parsedRes["expires_in"],
      parsedRes["refresh_token"],
    ));
    return Future.value(parsedRes["id_token"]);
  }
  return Future.error("Refresh token failed");
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
