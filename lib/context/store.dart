import 'package:firebase_auth/firebase_auth.dart';

class AppStore {
  bool connected;
  String name;
  UserCredential? credential;

  AppStore({
    this.connected = false,
    this.name = 'User',
    this.credential,
  });
}
