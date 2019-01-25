import 'package:flutter/material.dart';
import 'package:myapp_flutter/models/models.dart';
import '../list_item/list_item.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  final Function onItemSelected;

  PlacesList({
    this.places = const [],
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: places
              .map((place) => ListItem(
                    placeName: place.name,
                    imageURL: place.imageURL,
                    itemOnTap: () => onItemSelected(context, place.key),
                  ))
              .toList()),
    );
  }
}
