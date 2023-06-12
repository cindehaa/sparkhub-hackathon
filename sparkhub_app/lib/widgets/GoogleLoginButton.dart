import 'package:flutter/material.dart';
import 'package:sparkhub_app/screens/home_screen.dart';
import 'package:sparkhub_app/utils/authentication.dart';
import 'package:sparkhub_app/utils/user_db.dart';


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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            print('Signed In');
            print(user.uid);
            print(user.displayName);
            print(user.email);
            storeUserInFirebase(user.uid, user.displayName, user.email);
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
