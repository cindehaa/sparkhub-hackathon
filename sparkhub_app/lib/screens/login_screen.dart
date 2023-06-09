import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Sparkhub Hackathon App'),
          MaterialButton(
            onPressed: () {},
            child: const Text('Login with Google'),
          )
        ],
      ),
    );
  }
}
