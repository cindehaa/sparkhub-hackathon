// Stores users into the database after they've logged in

import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();

void storeUserInFirebase(String id, String? name, String? email) {
  final userProfiles = database.child('userProfiles/$id');

  userProfiles.set({'name': name, 'email': email}).then((value) {
    print('User stored successfully in Firebase');
  }).catchError((error) {
    print('Failed to store user name or email in Firebase: $error');
  });
}
