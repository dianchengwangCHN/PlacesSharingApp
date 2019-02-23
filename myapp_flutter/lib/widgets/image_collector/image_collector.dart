import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myapp_flutter/widgets/ui/primary_button.dart';

class ImageCollector extends StatelessWidget {
  final File image;
  final Function imagePickHandler;

  ImageCollector({
    this.image,
    this.imagePickHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.96,
          height: MediaQuery.of(context).size.width * 0.54,
          child: image == null
              ? Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "No image selected",
                      style: TextStyle(fontSize: 24),
                    ),
                  ))
              : Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
        )),
        Center(
          child: PrimaryButton(
            text: "Pick Image",
            onPressed: imagePickHandler,
          ),
        ),
      ],
    );
  }
}
