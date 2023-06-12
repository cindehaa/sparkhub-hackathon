// Stores users into the database after they've logged in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/utils/authentication.dart';


final database = FirebaseDatabase.instance.ref('userProfiles/');
FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid;


Future<List<listing_model>> retrieveListingsInFirebase() async {
  final ref = FirebaseDatabase.instance.ref('userProfiles/');
  final snapshot = await ref.child('$uid/userListings').get();
  print(snapshot.value);

  List<listing_model> list = [];
  return list;


}


