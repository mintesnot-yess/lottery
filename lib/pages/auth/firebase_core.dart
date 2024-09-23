import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery/pages/auth/signin.dart';

class AuthService {
  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } on FirebaseAuthException catch (e) {
      print("Error creating user: ${e.message}");
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage =
            'Password is too weak. It should be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one number.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already in use.';
      } else if (e.code == 'email-invalid') {
        errorMessage = 'Email is not valid.';
      } else {
        errorMessage = 'An error occurred while creating the user.';
      }

      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } on FirebaseAuthException catch (e) {
      print("Error creating user: ${e.message}");
      String errorMessage = '';
      if (e.code == 'email-invalid') {
        errorMessage = 'Email is not valid.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found for this email address';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'wrong password';
      } else {
        errorMessage = 'An error occurred while creating the user.';
      }

      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> LogOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
