import 'package:flutter/material.dart';
import 'package:myapp_flutter/containers/drawer.dart' as DrawerContainer;
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:myapp_flutter/widgets/ui/primary_button.dart';
import 'package:myapp_flutter/widgets/ui/default_input.dart';

class SharePlacePage extends StatefulWidget {
  @override
  _SharePlacePageState createState() => _SharePlacePageState();
}

class _SharePlacePageState extends State<SharePlacePage> {
  File _image;
  double _latitude;
  double _longitude;
  String placeName;

  @override
  void initState() {
    super.initState();
    _latitude = 39.9611755;
    _longitude = -82.9987942;
  }

  GoogleMapController _mapController;

  Future _getImage() async {
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
      _mapController.addMarker(MarkerOptions(
        position: LatLng(_latitude, _longitude),
        visible: true,
      ));
    });
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
                onPressed: _getImage,
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
              ),
            ),
            Center(
              child: PrimaryButton(
                text: "Locate Me",
                onPressed: () {},
              ),
            ),
            DefaultInput(
              decoration: InputDecoration(
                hintText: "Place Name",
              ),
              keyboardType: TextInputType.text,
            )
          ],
        ),
      ),
    );
  }
}
