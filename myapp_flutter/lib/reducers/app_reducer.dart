import '../models/models.dart';
import './places_reducer.dart';
import './placeAdded_reducer.dart';
import './loading_reducer.dart';
import './auth_reducer.dart';

AppState appReducer(AppState prev, dynamic action) {
  return AppState(
    places: placesReducer(prev.places, action),
    placeAdded: placeAddedReducer(prev.placeAdded, action),
    isLoading: loadingReducer(prev.isLoading, action),
    auth: authReducer(prev.auth, action),
  );
}
