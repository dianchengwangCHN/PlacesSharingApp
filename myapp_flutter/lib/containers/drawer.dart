import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp_flutter/models/models.dart';
import 'package:myapp_flutter/actions/app_actions.dart';
import 'package:myapp_flutter/widgets/side_drawer/side_drawer.dart';

class Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => SideDrawer(
            onLogout: vm.onLogout,
          ),
    );
  }
}

class _ViewModel {
  final Function onLogout;

  _ViewModel({
    this.onLogout,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        onLogout: (BuildContext context) => store.dispatch(logout(context)));
  }
}
