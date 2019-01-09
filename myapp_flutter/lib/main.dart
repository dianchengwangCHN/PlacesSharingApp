import 'package:flutter/material.dart';
import './pages/auth/auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(button: TextStyle(fontSize: 20)),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue[400],
              disabledColor: Colors.grey[200],
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
              filled: true,
              fillColor: Colors.grey[200])),
      home: AuthPage(),
    );
  }
}
