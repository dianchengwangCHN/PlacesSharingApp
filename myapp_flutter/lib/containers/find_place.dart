import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp_flutter/models/models.dart';
import 'package:myapp_flutter/pages/find_place/find_place_page.dart';

class FindPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => FindPlacePage(
            places: vm.places,
            onLoadPlaces: vm.onLoadPlaces,
          ),
    );
  }
}

class _ViewModel {
  final List<Place> places;
  final Function onLoadPlaces;

  _ViewModel({
    this.places,
    this.onLoadPlaces,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      places: store.state.places,
      onLoadPlaces: () => store.dispatch,
    );
  }
}
