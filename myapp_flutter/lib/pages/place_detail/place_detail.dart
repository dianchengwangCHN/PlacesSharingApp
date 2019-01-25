import 'package:flutter/material.dart';

class PlaceDetail extends StatelessWidget {
  final String placeName;
  final double latitude;
  final double longitude;
  final String imageURL;

  PlaceDetail({
    this.placeName,
    this.imageURL,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeName),
      ),
      body: Container(
        margin: EdgeInsets.all(22),
        child: Column(
          children: <Widget>[
            Image.network(imageURL),
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
