import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Sign In
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleAuthException(e);
      return errorMessage;
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Reset Password
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleAuthException(e);
      return errorMessage;
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Sign Up
  Future<String?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      sendEmailVerification();
      saveUserInfo(name, email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleAuthException(e);
      return errorMessage;
    } catch (e) {
      return 'Error: $e';
    }
    return null;
  }

  // Save user info
  Future<String?> saveUserInfo(
    String name,
    String email,
  ) async {
    try {
      await _firestore.collection('data').doc(_auth.currentUser!.uid).set({
        'name': name,
        'email': email,
        'leaderboardScore': 0,
        'previousScore': 0,
        'presentScore': 0,
        'uid': _auth.currentUser!.uid,
      });
      return null;
    } catch (e) {
      return "Error: $e";
    }
  }

  // Get user info
  Future<DocumentSnapshot?> getUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('data').doc(_auth.currentUser!.uid).get();
      if (userDoc.exists) {
        return userDoc;
      }
    }
    return null;
  }

  // Email Verification
  Future<String?> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return null;
      } else {
        return 'No user or user already verified';
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleAuthException(e);
      return errorMessage;
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Error signing out: $e');
    }
  }

  // Sign In With Google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Save user info
        await _saveGoogleUserInfo(userCredential.user);

        return null;
      }
      return 'Google sign-in cancelled';
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleAuthException(e);
      return errorMessage;
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<void> _saveGoogleUserInfo(User? user) async {
    if (user != null) {
      final userDoc = await _firestore.collection('data').doc(user.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('data').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'leaderboardScore': 0,
          'previousScore': 0,
          'presentScore': 0,
          'uid': user.uid,
        });
      }
    }
  }

  // Handling All Exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid Login Credentials';
      default:
        return 'Error: ${e.message}';
    }
  }
}
