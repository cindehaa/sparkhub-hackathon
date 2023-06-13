// Stores users into the database after they've logged in
import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();

void storeUserInFirebase(
    String id, String? name, String? email, Function() callback) {
  final userProfiles = database.child('userProfiles');
  userProfiles.child(id).once(DatabaseEventType.value).then((value) => {
        if (!value.snapshot.exists)
          {
            userProfiles.child(id).set({
              'name': name,
              'email': email,
            }).then((value) {
              print('User stored successfully in Firebase');
              callback();
            }).catchError((error) {
              print('Failed to store user name or email in Firebase: $error');
            })
          }
        else
          {callback()}
      });
}
