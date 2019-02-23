import 'package:flutter/material.dart';
import 'package:myapp_flutter/containers/drawer.dart' as DrawerContainer;
import '../../widgets/places_list/places_list.dart';
import 'package:myapp_flutter/models/models.dart';
import 'package:myapp_flutter/containers/place_detail_container.dart';

class FindPlacePage extends StatefulWidget {
  final List<Place> places;
  final Function onLoadPlaces;

  FindPlacePage({
    this.places,
    this.onLoadPlaces,
  });

  @override
  _FindPlacePageState createState() => _FindPlacePageState();
}

class _FindPlacePageState extends State<FindPlacePage> {
  Function _itemSelectedHandler;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      widget.onLoadPlaces();
    }
    _itemSelectedHandler = (BuildContext context, String key) {
      Place selPlace = widget.places.firstWhere((place) => place.key == key);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailContainer(
                  place: selPlace,
                ),
          ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerContainer.Drawer(),
      appBar: AppBar(
        title: Text("Find Place"),
      ),
      body: Container(
        child: PlacesList(
          places: widget.places,
          onItemSelected: _itemSelectedHandler,
        ),
      ),
    );
  }
}
