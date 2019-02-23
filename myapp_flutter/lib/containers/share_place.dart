import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp_flutter/models/models.dart';
import 'package:myapp_flutter/actions/app_actions.dart';
import 'package:myapp_flutter/pages/share_place/share_place_page.dart';
import 'dart:io';

class SharePlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => SharePlacePage(
            isLoading: vm.isLoading,
            placeAdded: vm.placeAdded,
            onAddPlace: vm.onAddPlace,
            onStartAddPlace: vm.onStartAddPlace,
          ),
    );
  }
}

class _ViewModel {
  bool isLoading;
  bool placeAdded;
  Function onAddPlace;
  Function onStartAddPlace;

  _ViewModel({
    this.isLoading,
    this.placeAdded,
    this.onAddPlace,
    this.onStartAddPlace,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoading: store.state.isLoading,
      placeAdded: store.state.placeAdded,
      onAddPlace:
          (String placeName, double latitude, double longitude, File image) =>
              store.dispatch(addPlace(placeName, latitude, longitude, image)),
      onStartAddPlace: () => store.dispatch(StartAddPlaceAction()),
    );
  }
}
