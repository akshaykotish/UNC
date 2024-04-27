import 'package:flutter/material.dart';
import 'package:unc/Screens/Signup.dart';
import 'package:unc/Screens/Splash.dart';

import 'BodyParts/Futurestic.dart';
import 'Screens/Login.dart';
import 'package:unc/BodyParts/AnimatedBackground.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.barlowTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomPaint(
        child: SplashScreen(),
      )
    );
  }
}
