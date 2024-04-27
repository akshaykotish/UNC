import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UNCTextField extends StatefulWidget {
  String hintText = "";
  TextEditingController controller;
  bool ispassword = false;
  IconData icondata;
  late FocusNode focusNode;

  UNCTextField({required this.hintText, required this.controller, required this.ispassword, required this.icondata, required this.focusNode});


  @override
  State<UNCTextField> createState() => _UNCTextFieldState();
}

class _UNCTextFieldState extends State<UNCTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      obscureText: widget.ispassword,
      controller: widget.controller,
      autofocus: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icondata, color: Colors.grey),
        fillColor: Colors.transparent, // Transparent background
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded borders
          borderSide: BorderSide.none, // No border lines
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding inside the TextField
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded borders when not focused
          borderSide: BorderSide.none, // No border lines
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded borders when focused
          borderSide: BorderSide(
            color: Colors.white, // Border color when focused
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(color: Colors.grey), // Hint text style
      ),
    );
  }
}
