import 'dart:async';

import 'package:chat_01/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splashScreen";
   
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), (){
      Navigator.pushReplacementNamed(context, LoadingPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff5a00),
      body: content(),
    );
  }

  Widget content(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 300,width: 300, child: Lottie.asset('assets/sanji.json')),
          Text('Welcome', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)
        ],
      ),
    );
  }
}