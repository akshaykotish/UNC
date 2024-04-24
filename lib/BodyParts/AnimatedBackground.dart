import 'package:flutter/material.dart';
import './FromHex.dart';

class AnimatedGradientBackground extends StatefulWidget {

  Widget child;
  AnimatedGradientBackground({required this.child});

  @override
  _AnimatedGradientBackgroundState createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _gradientColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust duration as needed
    )..repeat(reverse: true);

    // Define the gradient colors
    final Color startColor = Color(0xFF075985); // Dark blue
    final Color endColor = Color(0xFF0f172a); // Lighter blue

    _gradientColor = ColorTween(begin: startColor, end: endColor)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_gradientColor.value!, ColorFromHexCode("#075985")],
            ),
          ),
          // Add other UI elements on top of the background
          child: widget.child,
        );
      },
    );
  }
}
