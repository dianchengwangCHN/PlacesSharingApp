import 'package:flutter/material.dart';
import '../../widgets/side_drawer/side_drawer.dart';
import '../../widgets/places_list/places_list.dart';
import '../../pages/place_detail/place_detail.dart';
import 'package:myapp_flutter/models/models.dart';

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
              builder: (context) => PlaceDetail(
                    placeName: selPlace.name,
                    imageURL: selPlace.imageURL,
                  )));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
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
