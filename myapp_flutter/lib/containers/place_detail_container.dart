import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp_flutter/models/app_state.dart';
import 'package:myapp_flutter/actions/app_actions.dart';
import 'package:myapp_flutter/pages/place_detail/place_detail.dart';
import 'package:myapp_flutter/models/place.dart';

class PlaceDetailContainer extends StatelessWidget {
  final Place place;

  PlaceDetailContainer({
    this.place,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => PlaceDetail(
            place: place,
            onDeletePlace: vm.onDeletePlace,
          ),
    );
  }
}

class _ViewModel {
  Function onDeletePlace;

  _ViewModel({
    this.onDeletePlace,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        onDeletePlace: (String key, BuildContext context) => store.dispatch(
              deletePlace(key, context),
            ));
  }
}
