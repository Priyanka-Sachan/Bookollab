import 'package:flutter/material.dart';
import 'UI/SplashScreen.dart';
import 'UI/Onboarding.dart';
import 'UI/LoginPage.dart';
import 'UI/CreateAccountPage.dart';
import 'UI/Homepage.dart';
import 'UI/maindisplaypage.dart';
void main() {
  runApp(bookollab());
}

class bookollab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:SplashScreen.id,
      routes:{
        SplashScreen.id:(context) => SplashScreen(),
        Onboarding.id:(context) => Onboarding(),
        LoginPage.id:(context) => LoginPage(),
        CreateAccountPage.id:(context) => CreateAccountPage(),
        Homepage.id:(context) => Homepage(),
        maindisplaypage.id:(context)=>maindisplaypage(),

      } ,
    );
  }
}

