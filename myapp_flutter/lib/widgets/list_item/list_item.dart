import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String placeName;
  final String imageURL;
  final Function itemOnTap;

  ListItem({
    this.placeName,
    this.imageURL,
    this.itemOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 30,
                width: 30,
                child: Image.network(imageURL, fit: BoxFit.fill),
              ),
              Text(placeName ?? "123"),
            ],
          ),
        ),
        onTap: itemOnTap,
      ),
    );
  }
}
