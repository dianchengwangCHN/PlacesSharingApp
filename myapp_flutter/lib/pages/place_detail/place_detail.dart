import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.96,
                height: MediaQuery.of(context).size.width * 0.54,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              placeName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  controller.addMarker(MarkerOptions(
                    position: LatLng(latitude, longitude),
                  ));
                },
              ),
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
