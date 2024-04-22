import 'package:flutter/material.dart';
import 'package:unc/UNCRequest/Basic.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Basic basic = Basic();

  // Controllers to handle text input
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  // Variables to manage state
  bool _otpRequested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // UserID Field
            TextField(
              controller: _userIDController,
              decoration: InputDecoration(
                labelText: 'User ID',
              ),
            ),
            // Password Field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true, // Hide password
            ),
            SizedBox(height: 16.0),
            // Request OTP Button
            ElevatedButton(
              onPressed: () {
                // Handle Request OTP action
                requestOTP();
              },
              child: Text('Request OTP'),
            ),
            if (_otpRequested)
            // OTP Field (visible only after OTP is requested)
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'OTP',
                ),
              ),
            SizedBox(height: 16.0),
            // Login Button
            ElevatedButton(
              onPressed: () {
                // Handle Login action
                handleLogin();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle Request OTP action
  void requestOTP() {
    basic.RequestOTP("UNI2846122", "Shivamkumar&1");
    // Simulate requesting OTP
    setState(() {
      _otpRequested = true;
    });
    // In a real application, integrate an API call to request OTP
    print('Requesting OTP...');
  }

  // Function to handle Login action
  void handleLogin() {
    basic.Run();
    // Simulate verifying the OTP
    // if (_otpRequested) {
    //   //basic.RequestLogin("UNI2846122", "Shivamkumar&1", _otpController.text);
    //   // Simulate successful login
    //   print('Login successful!');
    // } else {
    //   // Invalid OTP
    //   print('Invalid OTP!');
    // }
    // In a real application, integrate login verification here
  }
}