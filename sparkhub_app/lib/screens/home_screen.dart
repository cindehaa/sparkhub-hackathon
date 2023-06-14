import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparkhub_app/widgets/home_screen/Navbar.dart';
import 'package:sparkhub_app/widgets/home_screen/buy_page.dart';
import 'package:sparkhub_app/widgets/home_screen/create_listing_page.dart';
import 'package:sparkhub_app/widgets/profile_screen/profile_page.dart';

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
          width: 2,
          thickness: 2,
        ),
        Expanded(
          child: IndexedStack(
            index: navValue,
            children: const <Widget>[
              ProfilePage(),
              BuyPage(),
              CreateListingPage(),
            ],
          ),
        )
      ],
    );
  }
}
