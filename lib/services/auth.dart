import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static get userStream => FirebaseAuth.instance.authStateChanges();
  static get user => FirebaseAuth.instance.currentUser;

  static Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }}