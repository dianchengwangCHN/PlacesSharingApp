import '../actions/app_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoadingAction>(_startLoading),
  TypedReducer<bool, StopLoadingAction>(_stopLoading),
]);

bool _startLoading(bool prev, dynamic action) {
  return true;
}

bool _stopLoading(bool prev, dynamic action) {
  return false;
}
