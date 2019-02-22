import 'package:flutter/material.dart';
import 'package:myapp_flutter/containers/drawer.dart' as DrawerContainer;
import 'package:myapp_flutter/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:myapp_flutter/widgets/ui/primary_button.dart';
import 'package:myapp_flutter/widgets/ui/default_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class SharePlacePage extends StatefulWidget {
  @override
  _SharePlacePageState createState() => _SharePlacePageState();
}

class _SharePlacePageState extends State<SharePlacePage> {
  File _image;
  double _latitude;
  double _longitude;
  bool _postionUpdated;
  ItemInfo _placeName;

  GoogleMapController _mapController;
  Marker _placeMarker;

  @override
  void initState() {
    super.initState();
    _latitude = 39.9611755;
    _longitude = -82.9987942;
    _postionUpdated = false;
    _placeName = ItemInfo();
  }

  @override
  void dispose() {
    _mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  void _imagePickHandler() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 600,
    );
    setState(() {
      _image = image;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _mapController
          .addMarker(MarkerOptions(
            position: LatLng(_latitude, _longitude),
            draggable: true,
            visible: true,
          ))
          .then((marker) => _placeMarker = marker);
      _mapController.addListener(_onMapChanged);
    });
  }

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  void _extractMapInfo() {
    var position = _mapController.cameraPosition;
    _latitude = position.target.latitude;
    _longitude = position.target.longitude;
  }

  void _locationPickHandler() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _postionUpdated = true;
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(_latitude, _longitude),
      ),
    );

    _mapController.updateMarker(
      _placeMarker,
      MarkerOptions(
        position: LatLng(_latitude, _longitude),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerContainer.Drawer(),
      appBar: AppBar(
        title: Text("Share Place"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "Share a place with us!",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.96,
              height: MediaQuery.of(context).size.width * 0.54,
              child: _image == null
                  ? Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          "No image selected",
                          style: TextStyle(fontSize: 24),
                        ),
                      ))
                  : Image.file(
                      _image,
                      fit: BoxFit.cover,
                    ),
            )),
            Center(
              child: PrimaryButton(
                text: "Pick Image",
                onPressed: _imagePickHandler,
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: 200.0,
              child: GoogleMap(
                onMapCreated: (controller) => _onMapCreated(controller),
                initialCameraPosition: CameraPosition(
                  target: LatLng(_latitude, _longitude),
                  zoom: 12.0,
                ),
                trackCameraPosition: true,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
            ),
            Center(
              child: PrimaryButton(
                text: "Locate Me",
                onPressed: _image != null && _postionUpdated && _placeName.valid
                    ? _locationPickHandler
                    : null,
              ),
            ),
            DefaultInput(
              decoration: InputDecoration(
                hintText: "Place Name",
              ),
              valid: _placeName.valid,
              touched: _placeName.touched,
              keyboardType: TextInputType.text,
            ),
            Center(
              child: PrimaryButton(
                text: "Share This Place",
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
