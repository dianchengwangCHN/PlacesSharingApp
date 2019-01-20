import '../actions/app_actions.dart';
import '../models/models.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<Auth>([
  TypedReducer<Auth, AuthSetTokenAction>(_setAuthToken),
  TypedReducer<Auth, AuthRemoveTokenAction>(_removeAuthToken),
]);

Auth _setAuthToken(Auth auth, AuthSetTokenAction action) {
  return action.auth;
}

Auth _removeAuthToken(Auth auth, AuthRemoveTokenAction action) {
  return Auth();
}
