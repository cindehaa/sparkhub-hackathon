// Authenticates user with Google account

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String? uid;
String? userEmail;

final GoogleSignIn googleSignIn = GoogleSignIn();
String? name;
String? imageUrl;

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();
  User? user;

  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
        await _auth.signInWithPopup(authProvider);
    user = userCredential.user;
  } catch (error) {
    print(error);
  }

  if (user != null) {
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;
  }

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print('User signed out of the Google account');
}
