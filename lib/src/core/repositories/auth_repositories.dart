import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  /// google
  Future<UserCredential?> signInWithGoogle() async {
    late UserCredential userCredential;
    try {
      final result = await GoogleSignIn().signIn();
      final authentication = await result?.authentication;
      if (authentication != null) {
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );
        userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      }
      return userCredential;
    } catch (error) {
      debugPrint("errornya = ${error.toString()}");
      return null;
    }
  }

  ///facebook
  Future<String?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;
      return accessToken?.token;
    } else {
      return null;
    }
  }
}
