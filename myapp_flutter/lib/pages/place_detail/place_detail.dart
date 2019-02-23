import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:myapp_flutter/models/models.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;
  final Function onDeletePlace;

  PlaceDetail({
    this.place,
    this.onDeletePlace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
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
                  place.imageURL,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              place.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(place.latitude, place.longitude),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  controller.addMarker(MarkerOptions(
                    position: LatLng(place.latitude, place.longitude),
                  ));
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              iconSize: 30,
              onPressed: () => onDeletePlace(place.key, context),
            )
          ],
        ),
      ),
    );
  }
}
