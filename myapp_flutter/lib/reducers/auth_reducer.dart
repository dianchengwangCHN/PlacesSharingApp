import '../actions/app_actions.dart';
import '../models/models.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<Auth>([
  TypedReducer<Auth, SetTokenAction>(_setAuthToken),
  TypedReducer<Auth, RemoveTokenAction>(_removeAuthToken),
]);

Auth _setAuthToken(Auth prev, SetTokenAction action) {
  return action.auth;
}

Auth _removeAuthToken(Auth prev, RemoveTokenAction action) {
  return Auth();
}
