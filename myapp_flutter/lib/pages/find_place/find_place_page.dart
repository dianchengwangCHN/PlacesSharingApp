import 'package:flutter/material.dart';
import '../../components/side_drawer/side_drawer_page.dart';

class FindPlacePage extends StatefulWidget {
  @override
  _FindPlacePageState createState() => _FindPlacePageState();
}

class _FindPlacePageState extends State<FindPlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Find Place"),
      ),
      body: Container(),
    );
  }
}
