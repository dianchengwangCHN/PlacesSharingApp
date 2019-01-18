import '../models/models.dart';
import './places_reducer.dart';
import './placeAdded_reducer.dart';
import './loading_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    places: placesReducer(state.places, action),
    placeAdded: placeAddedReducer(state.placeAdded, action),
    isLoading: loadingReducer(state.isLoading, action),
  );
}
