// lib/main.dart
import 'package:flutter/material.dart';
import 'WelcomePage.dart';
import 'SignUpPage.dart';
import 'SignInPage.dart';
import 'homepage.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aesthetic Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Suwannaphum', // will fall back if font not present
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const WelcomePage(),
        '/signup': (ctx) => const SignUpPage(),
        '/signin': (ctx) => const SignInPage(),
        '/home': (ctx) => const HomePage(),
      },
    );
  }
}
