import 'package:flutter/material.dart';

class UNCButton extends StatefulWidget {
  String ButtonName = "";
  Function onCLick;

  UNCButton({required this.ButtonName, required this.onCLick});

  @override
  _UNCButtonState createState() => _UNCButtonState();


}

class _UNCButtonState extends State<UNCButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and Animation
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose of the controller when not needed
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    // Animate button when pressed down
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    // Reverse animation when button is released
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ElevatedButton(
            onPressed:(){
                widget.onCLick();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Button padding
              elevation: 10, // Shadow elevation
            ),
            child: Text(
              widget.ButtonName,
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 18, // Text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}