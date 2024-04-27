import 'package:flutter/material.dart';


class FuturisticBackgroundPainter extends CustomPainter {
  final double animationProgress;

  FuturisticBackgroundPainter(this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    // Draw futuristic shapes with animations
    // Here are some examples of shapes you can animate:

    // Animated circle
    paint.color = Colors.blue.withOpacity(animationProgress);
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.5),
      100 * animationProgress,
      paint,
    );

    // Animated line
    paint.color = Colors.red.withOpacity(animationProgress);
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.8),
      Offset(size.width * 0.9, size.height * 0.2),
      paint,
    );

    // Animated rectangle
    paint.color = Colors.green.withOpacity(animationProgress);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.5 - 50 * animationProgress,
        size.height * 0.5 - 50 * animationProgress,
        100 * animationProgress,
        100 * animationProgress,
      ),
      paint,
    );

    // Add more shapes and animations as desired
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is FuturisticBackgroundPainter &&
        oldDelegate.animationProgress != animationProgress;
  }
}

class FuturisticBackgroundScreen extends StatefulWidget {
  @override
  _FuturisticBackgroundScreenState createState() => _FuturisticBackgroundScreenState();
}

class _FuturisticBackgroundScreenState extends State<FuturisticBackgroundScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: FuturisticBackgroundPainter(_animationController.value),
            child: Container(),
          );
        },
      ),
    );
  }
}
