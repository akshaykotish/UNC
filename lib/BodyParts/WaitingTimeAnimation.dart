import 'package:flutter/material.dart';
import 'dart:math';

class WaitingTimeAnimation extends StatefulWidget {
  @override
  _WaitingTimeAnimationState createState() => _WaitingTimeAnimationState();
}

class _WaitingTimeAnimationState extends State<WaitingTimeAnimation> with SingleTickerProviderStateMixin {
  // List of investment quotes
  final List<String> quotes = [
    "The stock market is filled with individuals who know the price of everything, but the value of nothing. - Philip Fisher",
    "Risk comes from not knowing what you’re doing. - Warren Buffett",
    "It is not the strongest of the species that survive, nor the most intelligent, but the one most responsive to change. - Charles Darwin",
    "The stock market is a device for transferring money from the impatient to the patient. - Warren Buffett",
    "An investment in knowledge pays the best interest. - Benjamin Franklin"
  ];

  // Current quote
  late String currentQuote;

  // Animation controller for fade transition
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    // Set the initial quote
    setRandomQuote();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  // Method to set a random quote
  void setRandomQuote() {
    setState(() {
      // Choose a random quote
      currentQuote = quotes[Random().nextInt(quotes.length)];
      // Start the fade-in animation
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage("assets/images/loadingbg.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Center(
          child: FadeTransition(
            opacity: _controller,
            child: Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.8)
              ),
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentQuote,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}