import 'package:flutter/material.dart';
import 'package:sparkhub_app/widgets/GoogleLoginButton.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color(0xFF408444),
      body: Center(
      child: Padding(
      padding: const EdgeInsets.all(25.0),

      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children:  [
          
          Row( // logo + name
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              //Image.network(imageUrl), 
              // const Text(
              //   'Sparkhub \nHackathon App',
              //   style: TextStyle(
              //     color: Color(),
              //    )
              //   )
                            Text(
                'Sparkhub \nHackathon App',
                textAlign: TextAlign.center,
                style: GoogleFonts.lobster(
                  fontSize: 48,
                  textStyle: TextStyle(color: Color(0xFFEAD7B2)),
                  
                  
                ), 
                  
                )
                
                ],
          ),
          SizedBox(height: 30),

          Row( // about and description section
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,          
                children: [                
                Text(
                  'slogan',
                  style: GoogleFonts.lato(
                  fontSize: 36,
                  textStyle: TextStyle(color: Color(0xFFEAD7B2))
                  ),
                ),
                ],


              )
            ],
          ),
          // const Row( // login button row
          //   mainAxisAlignment: MainAxisAlignment.center,
            
          //   children: [GoogleLoginButton(),],
          // ),
          SizedBox(height: 30),
          Row( // login button row
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green, // background
    foregroundColor: Color(0xFFEAD7B2), // foreground
  ),
              child: Text("Log in/ sign up with Google"),
              onPressed: () {
                const GoogleLoginButton();
              },
          ),]
            
          ),
          
        
        ],

      )
      ),

    ),);
  }
}
