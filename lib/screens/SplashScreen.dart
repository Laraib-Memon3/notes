import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/Home_Screen.dart';

class splash_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(72, 91, 167, 1),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Center content vertically
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Paper who?\nNotepad’s got \nyou covered!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(245, 245, 245, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage('assets/images/spalshscreen.png'),
              width: 250,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
