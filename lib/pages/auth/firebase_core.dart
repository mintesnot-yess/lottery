import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery/pages/auth/signin.dart';

class AuthService {
  Future<void> signUp(
      {required String userName,
      required String phoneNumber,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      addUserDetail(email: email, phoneNumber: phoneNumber, userName: userName);

      Navigator.popAndPushNamed(context, '/home');
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> addUserDetail({
    required String userName,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      var CurrentUser = FirebaseAuth.instance.currentUser!;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      await _firestore.collection('users').doc(CurrentUser.uid).set({
        'name': userName,
        'phone': phoneNumber,
        'email': email,
        'user_id': CurrentUser.uid
        // Add any other user data you want to store
      });
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.popAndPushNamed(context, '/home');
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> LogOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, '/login');
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }
}
