import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final database = FirebaseDatabase.instance.ref('userProfiles/');
FirebaseAuth auth = FirebaseAuth.instance;
User? currentUser = auth.currentUser;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 500,
          child: IndexedStack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle),
                      Text('Name: ${currentUser?.displayName}'),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      )
                    ],
                  ),
                  Text('Email: ${currentUser?.email}'),
                  MaterialButton(
                    onPressed: () {},
                    child: const Text('Sign Out'),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.blue,
          width: 100,
          height: 100,
        )
      ],
    );
  }
}
