import 'dart:async';

import 'package:equationbalancer2/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const EquationBalancerScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
               height: 150, 
               width: 200,
                color: Colors.white,
                child: Center(
                  child: Image.asset('images/Logo/Black/PNG.png'), // Replace with path to your asset image
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
