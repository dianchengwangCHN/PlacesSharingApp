import './models.dart';

class AppState {
  final List<Place> places;
  final bool placeAdded;
  final Auth auth;
  final bool isLoading;

  AppState({
    this.places = const [],
    this.placeAdded = false,
    this.auth,
    this.isLoading = false,
  });

  AppState copyWith({
    List<Place> places,
    bool placeAdded,
    Auth auth,
    bool isLoading,
  }) {
    return AppState(
      places: places ?? this.places,
      placeAdded: placeAdded ?? this.placeAdded,
      auth: auth ?? this.auth,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
