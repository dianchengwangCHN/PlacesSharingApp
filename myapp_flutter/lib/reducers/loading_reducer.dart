import '../actions/app_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoadingAction>(_startLoading),
  TypedReducer<bool, StopLoadingAction>(_stopLoading),
]);

bool _startLoading(bool state, dynamic action) {
  return true;
}

bool _stopLoading(bool state, dynamic action) {
  return false;
}
