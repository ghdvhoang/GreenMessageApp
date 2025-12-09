import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of AuthService
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      //sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save user info if it does not exist
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
        'email': email,
        'uid': userCredential.user?.uid,
        },
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
      // create user
      UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
      // save user info in a separate doc
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
        'email': email,
        'uid': userCredential.user?.uid,
        },
      );
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
