// Stores users into the database after they've logged in

import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
final userProfiles = database.child('userProfiles/');
final userProfilesId = database.child('userProfiles/id');


void storeUserInFirebase(String id, String? name, String? email) {
    userProfiles.set({
        'id': id,
    }).then((value) {
        print('UserId stored successfully in Firebase');
    }).catchError((error) {
        print('Failed to store ID in Firebase: $error');
    });

    userProfilesId.set({
        'name': name,
        'email': email
    }).then((value) {
        print('User stored successfully in Firebase');
    }).catchError((error) {
        print('Failed to store user name or email in Firebase: $error');
    });
}
