import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of AuthService
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  // sign up
  Future<UserCredential?> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  //error handling
}
