// Stores users into the database after they've logged in

import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/utils/authentication.dart';

final ref = FirebaseDatabase.instance.ref();
FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid;

Future<List<listing_model>> retrieveListingsInFirebase() async {
  final snapshot = await ref.child('userProfiles/$uid/userListings').get();

  var s = snapshot.value as Map;
  var list = [];
  List<listing_model> listingList = [];
  for (final value in s.values) {
    list.add(value);
  }

  list.forEach((element) async {
    final listingSnapshot = await ref.child('listings/$element').get();
    var s = jsonDecode(jsonEncode(listingSnapshot.value));
    listing_model retrievedListing = listing_model().fromJson(s);
    listingList.add(retrievedListing);
  });
  return listingList;
}

Future<void> retrieveAllListingsInFirebase() async {
  final snapshot = await ref.child('listings').get();
  var s = snapshot.value as Map;
  List<dynamic> listingList = [];
  for (Map value in s.values) {
    listingList.add(listing_model().fromJson(jsonDecode(jsonEncode(value))));
  }
}
