import 'package:cats_breed_identifier/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CatBreedIdentifier());
}

class CatBreedIdentifier extends StatelessWidget {
  const CatBreedIdentifier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cats and Breed Identifier',
      home: SplashScreen(),
    );
  }
}
