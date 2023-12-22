import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 5,
      navigator: HomeScreen(),
      title: Text(
        'Cat Breed Identifier',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: Colors.pink,
        ),
      ),
      logo: Image.asset('assets/images/icon.jpg'),
      backgroundColor: Colors.white,
      logoWidth: 100,
      loaderColor: Colors.red,
      loadingText: Text(
        'Muhammad Adil FLutter Developer',
        style: TextStyle(
          fontSize: 16,
          color: Colors.pinkAccent,
        ),
      ),
    );
  }
}
