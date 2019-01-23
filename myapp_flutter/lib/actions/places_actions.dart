import '../models/models.dart';
import './app_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class StartAddPlaceAction {}

class PlaceAddedAction {}

class SetPlacesAction {
  final List<Place> places;

  SetPlacesAction({this.places});
}

class RemovePlaceAction {
  final Place place;

  RemovePlaceAction({this.place});
}
