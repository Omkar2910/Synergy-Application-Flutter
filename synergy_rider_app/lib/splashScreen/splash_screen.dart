import 'dart:async';

import 'package:flutter/material.dart';
import 'package:synergy_rider_app/mainScreens/home_screen.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';

class MysplashScreen extends StatefulWidget {
  const MysplashScreen({Key? key}) : super(key: key);

  @override
  State<MysplashScreen> createState() => _MysplashScreenState();
}

class _MysplashScreenState extends State<MysplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async {
      //if seller is already logged in already
      if (firebaseAuth.currentUser != null) {
        Navigator.pushReplacement(
            //.pushReplacement instead of .push
            context,
            MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        // //if seller not logged in
        Navigator.pushReplacement(
            //.pushReplacement instead of .push
            context,
            MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          children: [
            Image.asset("images/logo.png"),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Riders Delivery App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3),
              ),
            )
          ],
        )),
      ),
    );
  }
}
