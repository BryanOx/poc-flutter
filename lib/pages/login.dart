import 'package:flutter/material.dart';
import 'package:poc_flutter/utils/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              'Please, Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton(
              onPressed: signInWithFacebook,
              child: Text(
                'Login with Facebook'
              ),
            ),
            TextButton(
              onPressed: signInWithGoogle,
              child: Text(
                'Login with Google'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
