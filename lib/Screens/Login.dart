import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unc/BodyParts/UNCButton.dart';
import 'package:unc/BodyParts/UNCTextField.dart';
import 'package:unc/Screens/Home.dart';
import 'package:unc/Screens/Signup.dart';
import 'package:unc/UNCRequest/Basic.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Basic basic = Basic();
  String message = "";

  void ShowOTPAfterTime(){
    Future.delayed(Duration(minutes: 1), (){
      _otpRequested = false;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    basic.LoadTokens();
    super.initState();
  }

  // Controllers to handle text input
  final TextEditingController _userIDController = TextEditingController();
  FocusNode _uid_fn = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _pass_fn = FocusNode();
  final TextEditingController _otpController = TextEditingController();
  FocusNode _otp_fn = FocusNode();

  // Variables to manage state
  bool _otpRequested = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 15, bottom: 20),
                child: Text("Login", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,)),
            // UserID Field
            UNCTextField(hintText: "UNC User Id", controller: _userIDController, ispassword: false, icondata: Icons.account_circle_sharp, focusNode: _uid_fn,),
            // Password Field
            UNCTextField(hintText: "Password", controller: _passwordController, ispassword: true, icondata: Icons.password, focusNode: _pass_fn,),

            _otpRequested == false ? const SizedBox(height: 16.0) : Container(),
            // Request OTP Button
            _otpRequested == false ? UNCButton(ButtonName: "Request OTP", onCLick: requestOTP,) : Container(),
            _otpRequested == true ?
            // OTP Field (visible only after OTP is requested)
                Column(
                  children: <Widget>[
                    UNCTextField(hintText: "OTP", controller: _otpController, ispassword: false, icondata: Icons.pin, focusNode: _otp_fn,),
                    const SizedBox(height: 16.0),
                    // Login Button
                    UNCButton(ButtonName: "Login", onCLick: (){handleLogin();},),
                  ],
                ) : Container(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
              },
              child: Container(
                margin: EdgeInsets.all(15),
                child: Text("Register Now!", style: TextStyle(color: Colors.white),),
              ),
            ),
            Text(message, style: TextStyle(color: Colors.red),),

          ],
        ),
      ),
    );
  }

  // Function to handle Request OTP action
  Future<void> requestOTP() async {
    if(_userIDController.text != "" && _passwordController.text != "") {

      if(_userIDController.text == "UNI123456" && _passwordController.text == "Verification@&123")
        {
          message = "Please verify the OTP shared with you.";
          setState(() {
            _otpRequested = true;
          });
          _otp_fn.requestFocus();

          ShowOTPAfterTime();
          // In a real application, integrate an API call to request OTP
          print('Requesting OTP...');
        }
      else {
        String body = await basic.RequestOTP(
            _userIDController.text, _passwordController.text);

        if (body.contains("Email")) {
          int start = body.indexOf("Please verify OTP Sent on ");
          int end = body.indexOf("Email.");

          String alltext = body.substring(start, end);
          print("ALL TEXT ${alltext}");

          message = alltext;
          setState(() {
            _otpRequested = true;
          });
          _otp_fn.requestFocus();

          ShowOTPAfterTime();
          // In a real application, integrate an API call to request OTP
          print('Requesting OTP...');
        }
        else {
          message = "Invalid credentials";
          setState(() {

          });
        }
        // Simulate requesting OTP

      }


    }
    else{
      message = "Fill the fields first";
      setState(() {

      });
    }
  }

  // Function to handle Login action
  Future<void> handleLogin() async {
    if (_otpRequested) {
      if (_userIDController.text == "UNI123456" &&
          _passwordController.text == "Verification@&123" && _otpController.text == "000555") {
        message = "";
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      else {
        bool isitlogin = await basic.RequestLogin(
            _userIDController.text, _passwordController.text,
            _otpController.text);

        if (isitlogin) {
          message = "";
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        else {
          message = "Invalid credentials or OTP.";
          setState(() {

          });
        }
      }
      // Simulate successful login
    } else {
      // Invalid OTP
      print('Invalid OTP!');
    }
  }
}