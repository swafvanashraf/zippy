import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/intro.dart';

class SecondSplash extends StatefulWidget {
  const SecondSplash({super.key});

  @override
  State<SecondSplash> createState() => _SecondSplashState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _SecondSplashState extends State<SecondSplash> {
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 04),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => introPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              'asset/light.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Welcome to 👋',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color.fromARGB(255, 222, 222, 222)),
                ),
                Text(
                  '𝒁𝒊𝒑𝒑𝒚',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 90,
                      color: Color.fromARGB(255, 222, 222, 222)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'The best e-commerce app of the century for your daily needs!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 222, 222, 222)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
