import 'package:redux/redux.dart';
import '../actions/app_actions.dart';

final placeAddedReducer = combineReducers<bool>([
  TypedReducer<bool, StartAddPlaceAction>(_startAddPlace),
  TypedReducer<bool, PlaceAddedAction>(_placeAdded),
]);

bool _startAddPlace(bool prev, dynamic action) {
  return false;
}

bool _placeAdded(bool prev, dynamic action) {
  return true;
}
