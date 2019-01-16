import 'package:flutter/material.dart';

class PlaceDetail extends StatelessWidget {
  final String placeName;
  final double latitude;
  final double longitude;
  final String imageURL;

  PlaceDetail(
      {this.placeName = "", this.latitude, this.longitude, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("???"),
      ),
      body: Container(
        margin: EdgeInsets.all(22),
        child: Column(
          children: <Widget>[
            Image.network(
                "https://firebasestorage.googleapis.com/v0/b/myapp-1545699976369.appspot.com/o/places%2Fd925bbac-03e3-4785-aac5-589f1795af5c.jpg?alt=media&token=d925bbac-03e3-4785-aac5-589f1795af5c"),
            Text(
              placeName,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
