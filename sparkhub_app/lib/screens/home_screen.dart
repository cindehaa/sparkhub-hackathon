import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sparkhub_app/widgets/Navbar.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
late User? user;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navValue = 1;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Navbar(changeScreen: (value) {
          setState(() {
            navValue = value;
          });
        }),
        const VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        IndexedStack(
          index: navValue,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Profile Page'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Buy Page'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Add Page'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
