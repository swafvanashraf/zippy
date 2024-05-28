import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/view/screens/SecondSplash.dart';
import 'package:flutter_application_1/view/screens/bottomNavigationbar.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 04),
      () {
        if (auth.currentUser?.uid == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SecondSplash()),
          );
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => bottumNavigationbar()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 60, width: 80, child: logo()),
                Text(
                  '-𝒁𝒊𝒑𝒑𝒚',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )),
      ),
    );
  }
}
