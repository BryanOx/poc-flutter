import 'package:poc_flutter/context/actions.dart';

import 'store.dart';

AppStore updateConnectedStatusReducer(AppStore store, dynamic action) {
  if (action is UpdateConnectedStatusAction) {
    return AppStore(
      connected: action.connected
    );
  }
  return store;
}
