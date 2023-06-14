import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDetailsWidget extends StatefulWidget {
  final String name;
  final String email;
  final String farm;
  final String bio;

  const UserDetailsWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.farm,
    required this.bio,
  }) : super(key: key);

  @override
  _UserDetailsWidgetState createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  late DatabaseReference database;
  late FirebaseAuth auth;
  User? currentUser;

  bool showFarmTextBox = false;
  bool showBioTextBox = false;
  TextEditingController _farmTextEditingController = TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance.reference().child('userProfiles/');
    auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
  }

  @override
  void dispose() {
    _farmTextEditingController.dispose();
    _bioTextEditingController.dispose();
    super.dispose();
  }

  void updateFarmDatabase(String newText) async {
    final uid = currentUser!.uid;
    final snapshot = await database.child(uid).get();

    if (snapshot.exists) {
      await database.child(uid).update({'farm': newText});
    }

    print('Updating farm in the database with new text: $newText');
  }

  void updateBioDatabase(String newText) async {
    final uid = currentUser!.uid;
    final snapshot = await database.child(uid).get();

    if (snapshot.exists) {
      await database.child(uid).update({'bio': newText});
    }

    print('Updating bio in the database with new text: $newText');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                Text(widget.email),
                Text(widget.farm),
                Text(widget.bio),
                Visibility(
                  visible: showFarmTextBox,
                  child: TextFormField(
                    controller: _farmTextEditingController,
                    onFieldSubmitted: (value) {
                      updateFarmDatabase(value);
                      setState(() {
                        showFarmTextBox = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Press enter to submit',
                    ),
                  ),
                ),
                Visibility(
                  visible: showBioTextBox,
                  child: TextFormField(
                    controller: _bioTextEditingController,
                    onFieldSubmitted: (value) {
                      updateBioDatabase(value);
                      setState(() {
                        showBioTextBox = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Press enter to submit',
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            child: const Text('Edit Farm'),
            onPressed: () {
              setState(() {
                showFarmTextBox = !showFarmTextBox;
              });
            },
          ),
          TextButton(
            child: const Text('Edit Bio'),
            onPressed: () {
              setState(() {
                showBioTextBox = !showBioTextBox;
              });
            },
          ),
        ],
      ),
    );
  }
}
