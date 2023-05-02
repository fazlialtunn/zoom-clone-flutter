import 'package:flutter/material.dart';
import 'package:zoom_clone_flutter/resources/auth_methods.dart';
import 'package:zoom_clone_flutter/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start or join a meeting',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/onboarding.jpg'),
            ),
            CustomButton(
              text: 'Google Sign In',
              onPressed: () async {
                bool res = await _authMethods.signInWithGoogle(context);
                if (res) {
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
