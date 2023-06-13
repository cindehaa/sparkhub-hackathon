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
  if (snapshot.value == null) {
    return [listing_model()];
  } else {
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
}

Future<List<listing_model>> retrieveAllListingsInFirebase() async {
  final snapshot = await ref.child('listings').get();
  var s = snapshot.value as Map;
  List<listing_model> listingList = [];
  for (Map value in s.values) {
    listingList.add(listing_model().fromJson(jsonDecode(jsonEncode(value))));
  }
  return listingList;
}
