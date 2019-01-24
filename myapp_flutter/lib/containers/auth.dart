import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp_flutter/models/app_state.dart';
import 'package:myapp_flutter/actions/app_actions.dart';
import 'package:myapp_flutter/pages/auth/auth_page.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return AuthPage(
          isLoading: vm.isLoading,
          onTryAuth: vm.onTryAuth,
          onAutoSignIn: vm.onAutoSignIn,
        );
      },
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final Function onTryAuth;
  final Function onAutoSignIn;

  _ViewModel({
    this.isLoading,
    this.onTryAuth,
    this.onAutoSignIn,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoading: store.state.isLoading,
      onTryAuth: (String email, String password, String authMode,
              BuildContext context) =>
          store.dispatch(tryAuth(email, password, authMode, context)),
      onAutoSignIn: (BuildContext context) =>
          store.dispatch(autoSignIn(context)),
    );
  }
}
