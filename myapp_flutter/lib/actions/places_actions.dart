import '../models/models.dart';
import './app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
    var response = await client.get(url);
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
