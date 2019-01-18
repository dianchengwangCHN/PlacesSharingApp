import 'package:redux/redux.dart';
import '../actions/app_actions.dart';
import '../models/models.dart';

final placesReducer = combineReducers<List<Place>>([
  TypedReducer<List<Place>, SetPlacesAction>(_setPlaces),
]);

List<Place> _setPlaces(List<Place> places, SetPlacesAction action) {
  return action.places;
}
