import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_app/authentication/auth_screen.dart';

class MysplashScreen extends StatefulWidget {
  const MysplashScreen({Key? key}) : super(key: key);

  @override
  State<MysplashScreen> createState() => _MysplashScreenState();
}

class _MysplashScreenState extends State<MysplashScreen> {


startTimer()
{
  Timer(const Duration(seconds: 8), () async{
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
  } );
  
}

@override
void initState()
{
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
            Image.asset("images/splash.jpg"),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Sell food online ",
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
