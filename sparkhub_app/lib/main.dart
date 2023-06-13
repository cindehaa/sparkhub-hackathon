import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sparkhub_app/screens/home_screen.dart';

import 'package:sparkhub_app/widgets/GoogleLoginButton.dart';

import 'firebase_options.dart';
import 'package:sparkhub_app/screens/login_screen.dart';
import 'package:sparkhub_app/screens/home_screen.dart';
// import 'package:sparkhub_app/screens/backend-testing/test.dart';
import 'package:sparkhub_app/backend/firebase.dart';
import 'package:sparkhub_app/widgets/buy_screen/item_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      initialRoute: '/',
    );
  }
}
