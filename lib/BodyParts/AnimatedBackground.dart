import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        return Stack(
          children: [
            Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/uncicons/background.gif"),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Opacity(
              opacity: 0.95,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_gradientColor.value!, ColorFromHexCode("#075985")],
                  ),
                ),
                // Add other UI elements on top of the background
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}
//
// class AnimatedGradientBackground extends StatefulWidget {
//
//   Widget child;
//   AnimatedGradientBackground({super.key, required this.child});
//
//   @override
//   State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
// }
//
// class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/uncicons/background.gif"),
//               fit: BoxFit.fill,
//             )
//         ),
//         child: widget.child,
//       ),
//     );
//   }
// }
