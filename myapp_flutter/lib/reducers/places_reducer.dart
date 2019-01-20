import 'package:redux/redux.dart';
import '../actions/app_actions.dart';
import '../models/models.dart';

final placesReducer = combineReducers<List<Place>>([
  TypedReducer<List<Place>, SetPlacesAction>(_setPlaces),
  TypedReducer<List<Place>, RemovePlaceAction>(_removePlace),
]);

List<Place> _setPlaces(List<Place> places, SetPlacesAction action) {
  return action.places;
}

List<Place> _removePlace(List<Place> places, RemovePlaceAction action) {
  return places.where((place) => place.key != action.place.key).toList();
}
