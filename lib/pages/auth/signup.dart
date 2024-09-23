import 'package:flutter/material.dart';
import 'package:lottery/main.dart';
import 'package:lottery/pages/auth/firebase_core.dart';
import 'package:lottery/pages/auth/signin.dart';

void main() => runApp(const MyApp());

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create a new account',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () async {
                await AuthService().signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context);
              },
              child: const Text('Sign Up'),
            ),
            MaterialButton(
              onPressed: () {
//navigate to home page
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: const Text('sign-in'),
            )
          ],
        ),
      ),
    );
  }
}
