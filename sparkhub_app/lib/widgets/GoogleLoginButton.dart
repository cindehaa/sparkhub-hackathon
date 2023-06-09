import 'package:flutter/material.dart';
import 'package:sparkhub_app/utils/authentication.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        setState(() {
          _isProcessing = true;
        });
        await signInWithGoogle().then((user) {
          print(user);
          if (user != null) {
            print('Signed In');
            print(user.uid);
          }
        }).catchError((error) {
          print('Registration Error: $error');
        });
        setState(() {
          _isProcessing = false;
        });
      },
      child: _isProcessing
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey))
          : const Text('Continue with Google'),
    );
  }
}