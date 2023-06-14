import 'package:flutter/material.dart';
import 'package:sparkhub_app/widgets/GoogleLoginButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //String imageUrl = "https://media.istockphoto.com/id/1170724138/vector/farmers-market-hand-drawn-lettering.jpg?s=612x612&w=0&k=20&c=__LbJVEDLc66smBIk7BRHgoo2HfCYysOGJfiTD3AImA=";

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 132, 68),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // logo + name
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/harvest_hub.png',
                      height: 600,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Farmers market at\nyour fingertips',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 75,
                              textStyle: const TextStyle(shadows: [
                                Shadow(
                                  offset: Offset(6, 6),
                                  blurRadius: 2,
                                  color: Color.fromARGB(134, 5, 46, 4),
                                )
                              ], color: Color.fromARGB(255, 234, 215, 178)),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          GoogleLoginButton()
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
