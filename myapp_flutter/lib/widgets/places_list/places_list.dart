import 'package:flutter/material.dart';
import '../list_item/list_item.dart';

class PlacesList extends StatelessWidget {
  final List<String> places;
  final Function onItemSelected;

  PlacesList({this.places = const ["1", "2"], this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: places
              .map((place) => ListItem(
                    placeName: place,
                    itemOnTap: onItemSelected,
                  ))
              .toList()),
    );
  }
}
