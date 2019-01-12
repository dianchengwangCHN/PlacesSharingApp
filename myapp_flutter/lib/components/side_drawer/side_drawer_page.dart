import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.change_history, size: 24),
                    Text(
                      "Sign Out",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
            ],
          ),
        ),
        elevation: 20.0,
      ),
    );
  }
}
