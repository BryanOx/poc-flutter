// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poc_flutter/utils/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool authWithPhone = false;
  String phoneNumber = '';

  Future<void> signIn(String type) async {
    try {
      UserCredential credential;
      if (type == 'google') {
        credential = await signInWithGoogle();
        print(credential);
      } else if (type == 'facebook') {
        credential = await signInWithFacebook();
        print(credential);
      } else if (type == 'phone') {
        UserCredential? creds =
            await signInWithPhoneNumber('+598', phoneNumber);
        if (creds != null) {
          credential = creds;
        } else {
          throw Exception(
              'Error while login with phone number +598$phoneNumber');
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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
          children: authWithPhone
              ? <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Insert your phone number and choose country code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                      onChanged: (value) => setState(() {
                        phoneNumber = value;
                      }),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await signIn('phone');
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      authWithPhone = false;
                    }),
                    child: const Text('Go Back'),
                  ),
                ]
              : <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Text(
                    'Please, Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await signIn('facebook');
                    },
                    child: const Text('Login with Facebook'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await signIn('google');
                    },
                    child: const Text('Login with Google'),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      authWithPhone = true;
                    }),
                    child: const Text('Login with your phone number'),
                  ),
                ],
        ),
      ),
    );
  }
}
