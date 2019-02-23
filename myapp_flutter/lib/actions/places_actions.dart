import 'dart:io';
import '../models/models.dart';
import './app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class StartAddPlaceAction {}

class PlaceAddedAction {}

class SetPlacesAction {
  final List<Place> places;

  SetPlacesAction({this.places});
}

class RemovePlaceAction {
  final String key;

  RemovePlaceAction({this.key});
}

ThunkAction<AppState> getPlaces() {
  return (Store<AppState> store) async {
    String token = await getToken(store);
    String url =
        "https://myapp-1545699976369.firebaseio.com/places.json?auth=" + token;
    Client client = Client();
    Response response = await client.get(url);
    if (response.statusCode != 200) {
      print("Http StatusCode: ${response.statusCode}");
    }
    Map<String, dynamic> parsedRes = jsonDecode(response.body);
    List<Place> places = [];
    parsedRes.forEach((String key, value) {
      places.add(Place(
        key: key,
        name: value["name"],
        imageURL: value["image"],
        latitude: value["location"]["latitude"],
        longitude: value["location"]["longitude"],
      ));
    });
    store.dispatch(SetPlacesAction(places: places));
  };
}

ThunkAction<AppState> addPlace(
    String placeName, double latitude, double longitude, File image) {
  return (Store<AppState> store) async {
    store.dispatch(StartLoadingAction());
    Response response;
    Client client = Client();
    String token;
    try {
      token = await getToken(store);
      String base64Image = base64Encode(image.readAsBytesSync());
      String url =
          "https://us-central1-myapp-1545699976369.cloudfunctions.net/storeImage";
      response = await client.post(url,
          body: jsonEncode({"image": base64Image}),
          headers: {"Authorization": "Bearer " + token});
    } catch (e) {
      store.dispatch(StopLoadingAction());
      throw e;
    }
    Map<String, dynamic> parsedRes = jsonDecode(response.body);
    try {
      String url =
          "https://myapp-1545699976369.firebaseio.com/places.json?auth=" +
              token;
      response = await client.post(
        url,
        body: jsonEncode({
          "name": placeName,
          "location": {
            "latitude": latitude,
            "longitude": longitude,
          },
          "image": parsedRes["imageUrl"],
          "imagePath": parsedRes["imagePath"]
        }),
      );
      store.dispatch(StopLoadingAction());
      store.dispatch(PlaceAddedAction());
    } catch (e) {
      store.dispatch(StopLoadingAction());
      throw e;
    }
  };
}

ThunkAction<AppState> deletePlace(String key, BuildContext context) {
  return (Store<AppState> store) async {
    try {
      String token = await getToken(store);
      String url = "https://myapp-1545699976369.firebaseio.com/places/" +
          key +
          ".json?auth=" +
          token;
      Client client = Client();
      Response response = await client.delete(url);
      print(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
    store.dispatch(RemovePlaceAction(key: key));
    Navigator.pop(context);
  };
}
