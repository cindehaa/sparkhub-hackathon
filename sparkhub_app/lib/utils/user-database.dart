// Stores users into the database after they've logged in

import 'package:firebase_database/firebase_database.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

    final userDatabase = FirebaseDatabase.instance.ref();
    final userProfiles = userDatabase.child('userProfiles/');

    void storeUserInFirebase(String id) {
        userProfiles.set({
            'id': id,
        }).then((value) {
            print('User stored successfully in Firebase');
        }).catchError((error) {
            print('Failed to store ID in Firebase: $error');
        });
    }
