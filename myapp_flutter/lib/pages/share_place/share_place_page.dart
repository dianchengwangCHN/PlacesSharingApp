import 'package:flutter/material.dart';
import '../../widgets/side_drawer/side_drawer.dart';

class SharePlacePage extends StatefulWidget {
  @override
  _SharePlacePageState createState() => _SharePlacePageState();
}

class _SharePlacePageState extends State<SharePlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Share Place"),
      ),
      body: Container(),
    );
  }
}
