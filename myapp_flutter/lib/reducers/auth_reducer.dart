import '../actions/app_actions.dart';
import '../models/models.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<Auth>([
  TypedReducer<Auth, AuthSetTokenAction>(_setAuthToken),
  TypedReducer<Auth, AuthRemoveTokenAction>(_removeAuthToken),
]);

Auth _setAuthToken(Auth prev, AuthSetTokenAction action) {
  return action.auth;
}

Auth _removeAuthToken(Auth prev, AuthRemoveTokenAction action) {
  return Auth();
}
