import 'package:redux/redux.dart';
import './navigator_action.dart';
import './navigator_state.dart';

final bottomNavigatorReducer = combineReducers<BottomNavigatorState>([
  TypedReducer<BottomNavigatorState, SetBottomNavigatorNumAction>(
      _setBottomNavigatorNumAction),
]);

BottomNavigatorState _setBottomNavigatorNumAction(
    BottomNavigatorState state, SetBottomNavigatorNumAction action) {
  return state.copyWith(navigation: action.navigation);
}
