import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './pages/auth/auth_page.dart';
import './pages/main_tabs/main_tabs_page.dart';
import './models/models.dart';
import './reducers/app_reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = Store<AppState>(
    appReducer,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              button: TextStyle(fontSize: 16),
              headline: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
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
            fillColor: Colors.grey[200],
          )),
      initialRoute: "/",
      routes: {
        "/": (context) => AuthPage(),
        "/mainTabs": (context) => MainTabsPage(),
      },
    );
  }
}
