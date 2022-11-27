import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithFacebook() async {
  try {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final token2 = loginResult.accessToken?.token;
    if (token2 != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(token2);

      // Once signed in, return the UserCredential
      UserCredential facebookCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return facebookCredential;
    } else {
      throw Exception('Error trying to authenticate with facebook');
    }
  } catch (error) {
    throw Exception(error.toString());
  }
}

Future<UserCredential> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential googleCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return googleCredential;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<UserCredential?> signInWithPhoneNumber(
    String number, String countryCode) async {
  String phoneNumber = "$countryCode${number.trim()}";
  print(phoneNumber);
  UserCredential? phoneNumberCredentials;

  /// The below functions are the callbacks, separated so as to make code more readable
  void verificationCompleted(AuthCredential phoneAuthCredential) async {
    print('verificationCompleted');
    phoneNumberCredentials =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
  }

  void verificationFailed(dynamic error) {
    print(error);
  }

  void codeSent(String verificationId, [int? code]) {
    print('codeSent');
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  await FirebaseAuth.instance.verifyPhoneNumber(
    /// Make sure to prefix with your country code
    phoneNumber: phoneNumber,

    /// `seconds` didn't work. The underlying implementation code only reads in `milliseconds`
    timeout: const Duration(milliseconds: 10000),

    /// If the SIM (with phoneNumber) is in the current device this function is called.
    /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
    verificationCompleted: verificationCompleted,

    /// Called when the verification is failed
    verificationFailed: verificationFailed,

    /// This is called after the OTP is sent. Gives a `verificationId` and `code`
    codeSent: codeSent,

    /// After automatic code retrival `tmeout` this function is called
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  ); // All the callbacks are above
  return phoneNumberCredentials;
}
