import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  void logoutHandler(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.exit_to_app, size: 30),
                      Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                onTap: () => logoutHandler(context),
              ),
            ],
          ),
        ),
        elevation: 20.0,
      ),
    );
  }
}
