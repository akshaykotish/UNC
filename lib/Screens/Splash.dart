import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unc/BodyParts/AnimatedBackground.dart';
import 'package:unc/Screens/Home.dart';
import 'package:unc/Screens/Login.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _opacityofwidget = 0.0;
  double _top = 380; // Initial top position of the logo (center of the screen)

  bool mounted = false;

  Future<void> CheckforCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookiesstring = prefs.getString('cookies');
    var dsb = await prefs.getString("dashboard");

    if(dsb != null && dsb == "FOUND" && cookiesstring != null && cookiesstring != "") {
      Map<String, dynamic> cookies = json.decode(cookiesstring);
      if(cookies["XSRF-TOKEN"] != null && cookies["uni_session"] != null)
        {
          if(mounted) {
            setState(() {
              _top = 380;
              _opacityofwidget = 0.0;
            });
          }
          Future.delayed(Duration(seconds: 3), (){
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
    }
  }

  @override
  void initState() {
    mounted = true;
    CheckforCookies();
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    // Start the animation sequence
    Future.delayed(Duration(seconds: 1), () {
      if(mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
      // After the fade-in animation is done, start moving the logo to the top
      Future.delayed(Duration(seconds: 2), () {
        if(mounted) {
          setState(() {
            _top = 50; // Move the logo to the top of the screen
          });
        }

        Future.delayed(Duration(seconds: 1), ()
        {
          if(mounted) {
            setState(() {
              _opacityofwidget = 1.0;
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: AnimatedGradientBackground(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: _top, // Control the vertical position of the logo
              left: MediaQuery.of(context).size.width / 2 - 100, // Center horizontally
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/logo.png', // Path to the logo image
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            // Another widget in the center of the screen
            Positioned.fill(
              top: 100,
              child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: _top < 100, // Show the widget when the logo moves to the top
                  child: AnimatedOpacity(
                    opacity: _opacityofwidget,
                    duration: Duration(seconds: 6),
                    child: LoginPage()
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}