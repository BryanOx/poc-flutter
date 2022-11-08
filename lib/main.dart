import 'package:flutter/material.dart';
import 'package:poc_flutter/context/store.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:poc_flutter/context/reducer.dart';
import 'package:poc_flutter/pages/login.dart';
import 'package:poc_flutter/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppStore> _store = Store<AppStore>(
    updateConnectedStatusReducer,
    initialState: AppStore(connected: false),
  );// * Create an instance of redux Store using the AppStore created
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      // * Accessing data from the store (here you can access any part of the store)
      child: StoreConnector<AppStore, AppStore>(
        converter: ((store) => store.state),
        builder: (context, AppStore store) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: !store.connected ? '/login' : '/',
          routes: {
            '/login': (context) =>  const LoginPage(title: 'Login Page'),
            '/': (context) => const MyHomePage(title: 'Home Page'),
            // '/profile':(context) => const ProfilePage(title: ),
          },
        ),
      ),
    );
  }
}
