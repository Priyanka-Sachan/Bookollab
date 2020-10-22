import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'Onboarding.dart';

class SplashScreen extends StatefulWidget {
  static String id='Splash_Screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 7);
    return Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.pushReplacementNamed(context, Onboarding.id);
  }
  @override
  void initState() {
    // TODO: implement initState
    startTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFf8e900),
      body: FlareActor(
        "UIAssets/Bookollab.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Untitled",
      ),
    );
  }
}
