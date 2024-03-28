import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodii_users_app/authentication/auth_screen.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:foodii_users_app/mainScreens/home_screen.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
       decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [ Colors.amber, Colors.cyan], begin: FractionalOffset(0.0, 0.0), end: FractionalOffset(1.0, 0.0), stops: [0.0,1.0], tileMode: TileMode.clamp) 
       ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/welcome.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Order Food Online with ifood",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "TrainOne",
                      letterSpacing: 3),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
