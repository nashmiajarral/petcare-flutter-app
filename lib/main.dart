import 'package:flutter/material.dart';
import 'utils/app_text_style.dart';
import 'package:petcare/screens/splash/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pet Care App",
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
