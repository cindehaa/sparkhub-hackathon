// Stores users into the database after they've logged in

import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/utils/authentication.dart';


final database = FirebaseDatabase.instance.ref('userProfiles/');
FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid;


Future<List> retrieveListingsInFirebase() async {
  final ref = FirebaseDatabase.instance.ref('userProfiles/');
  DataSnapshot snapshot = await ref.child('$uid/userListings').get();
  
  Map<String, Object> snapshotList = HashMap<String,Object>();
  var s = snapshot.value as Map;
  // List<Object> listings = snapshotList.values();


  print(s);
  var list = [];
  for (final value in s.values)
  {
    list.add(value);
    print(value);
  }
  return list;
  // s.forEach((key,value) => list.add(listing_model(value)));
  


  // for (var values in snapshot.getValue())
  // {
  //   list.add(listing_model(value));
  // }
  
// use strings to get data from listings and object


}


