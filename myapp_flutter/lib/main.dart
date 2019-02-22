import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:myapp_flutter/containers/auth.dart' as AuthContainer;
import 'package:myapp_flutter/pages/main_tabs/main_tabs_page.dart';
import 'package:myapp_flutter/models/models.dart';
import 'package:myapp_flutter/reducers/app_reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      places: [],
      placeAdded: true,
      auth: Auth(),
      isLoading: false,
    ),
    middleware: [thunkMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'MyApp',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
                button: TextStyle(fontSize: 16),
                headline: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blue[400],
                disabledColor: Colors.grey[300],
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            )),
        initialRoute: "/",
        routes: {
          "/": (context) => AuthContainer.Auth(),
          "/mainTabs": (context) => MainTabsPage(),
        },
      ),
    );
  }
}
