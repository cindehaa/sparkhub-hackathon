import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/screens/home_screen.dart';
import 'package:sparkhub_app/utils/authentication.dart';
import 'package:sparkhub_app/utils/retrive_user_listing.dart';
import 'package:sparkhub_app/widgets/home_screen/Navbar.dart';
import 'package:sparkhub_app/widgets/profile_screen/account_listings_widget.dart';
import 'package:sparkhub_app/widgets/profile_screen/profile_picture_widget.dart';
import 'package:sparkhub_app/widgets/profile_screen/user_details_widget.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Database
  late DatabaseReference database;
  late FirebaseAuth auth;
  User? currentUser;

  // User profile data
  String name = '';
  String email = '';
  String farm = '';
  String bio = '';
  late Future<List<listing_model>>? listings;
  bool waiting = true;

  @override
  void initState() {
    super.initState();

    database = FirebaseDatabase.instance.ref('userProfiles/');
    auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
    retrieveUserProfile();
    listings = retrieveListingsInFirebase();
  }

  void retrieveUserProfile() async {
    final uid = currentUser!.uid;
    final snapshot = await database.child(uid).get();

    if (snapshot.exists) {
      // Must map because snapshot.value is a dynamic type
      Map<String, dynamic> data_vals = snapshot.value as Map<String, dynamic>;

      setState(() {
        name = data_vals['name'];
        email = data_vals['email'];
        farm = data_vals['farm'];
        bio = data_vals['bio'];

        if (farm == null || farm == '') {
          farm = 'No Farm Added';
        }

        if (bio == null || bio == '') {
          bio = 'No Bio Added';
        }
      });
    } else {
      print('No data available.');
    }

    print(farm);
    print(bio);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Build the UI using the retrieved user profile data from the state
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile info
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.8,
                child: UserDetailsWidget(
                    name: name, email: email, farm: farm, bio: bio),
              ),
            ),
          ),

          // Spacing between profile info and listings
          Container(
            height: MediaQuery.of(context).size.height *
                0.05, // Set the height to 10% of the screen height
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              child: SizedBox(),
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: listings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      // heightFactor: 0.5,
                      child: AccountListingsWidget(history: snapshot.data!),
                    ),
                  );
                } else {
                  return const Text('You have no listings');
                }
              },
            ),
          )

          // Expanded(
          //   child: AccountHistoryWidget(history: accountHistory),
          // ),
        ],
      ),
    );
  }
}
