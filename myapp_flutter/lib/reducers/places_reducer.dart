import 'package:redux/redux.dart';
import '../actions/app_actions.dart';
import '../models/models.dart';

final placesReducer = combineReducers<List<Place>>([
  TypedReducer<List<Place>, SetPlacesAction>(_setPlaces),
  TypedReducer<List<Place>, RemovePlaceAction>(_removePlace),
]);

List<Place> _setPlaces(List<Place> prev, SetPlacesAction action) {
  return action.places;
}

List<Place> _removePlace(List<Place> prev, RemovePlaceAction action) {
  return prev.where((place) => place.key != action.place.key).toList();
}
