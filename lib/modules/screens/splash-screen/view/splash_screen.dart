import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/auth-helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Timer(Duration(seconds: 3), () {
      if (AuthHelper.auth.currentUser != null) {
        Get.offAllNamed('/navbar');
      } else {
        Get.offAllNamed('/login');
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: h / 4.5,
            ),
            Container(
              alignment: Alignment.center,
              height: h / 3,
              width: w / 1,
              child: Image.asset(
                'assets/splash_screen.gif',
              ),
            ),
            SizedBox(
              height: h / 3,
            ),
            Text(
              "KALENA MART",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
                letterSpacing: 5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
