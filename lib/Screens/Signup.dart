import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unc/UNCRequest/Basic.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late WebViewController _controller;
  final String url = 'https://example.com'; // Replace with your URL

  bool browserloaded = false;

  var controller = WebViewController();

  var cookies;
  Basic basic = Basic();

  Future<void> LoadCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookiesstring = prefs.getString('cookies');
    cookies = json.decode(cookiesstring!);
  }


  Future<void> Setup() async {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse("https://unicitizens.com/signup"));

    print("Removing Header");
    controller.setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url){
          String jscode = "document.getElementsByTagName('header')[0].innerHTML = " + '"' + "<div style='display: flex; flex-wrap: wrap; justify-content: center; align-items: center; align-content: center; width: 100%; height: 5vh; overflow: auto; flex-direction: row; color:white; font-weight:600; font-size:10pt;'><img src='https://unicitizens.com/images/logo.png' width='30%' /><div style='width:60%; text-align:right; margin-top:2%; margin-bottom:2%;'>Sign Up</div></div>" + '"';
          controller.runJavaScript(jscode);
          controller.runJavaScript('document.getElementById("dashboard").style = "background:black";');
          controller.runJavaScript("document.getElementsByClassName('relative')[0].style = 'margin-bottom: 5%';");
          print("Idm");
          String jscode2 = "document.getElementsByClassName('text-gray-300 text-sm text-left pl-2 mb-2')[0].innerHTML = " + '"' + "<a href='https://metamask.io/'><img src='https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/MetaMask_Fox.svg/2048px-MetaMask_Fox.svg.png' width='30px' height='30px' /> Create a MetaMask Wallet First</a>" + '"';
          controller.runJavaScript(jscode2);
          setState(() {
            browserloaded = true;
          });
          //controller.runJavaScript("document.getElementById('example_wrapper').style = 'margin-top:20%';");
        },
      onUrlChange: (url) async {
          var cookies = await controller.runJavaScriptReturningResult("document.cookie");
          print("MDMD");
          print(cookies);
          if(url.url!.toLowerCase().contains("signin") || url.url == "https://unicitizens.com/")
            {
              Navigator.pop(context);
            }
      }
    ));
  }

  @override
  void initState() {
    Setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back in WebView
            Navigator.pop(context);
          },
        ),
        title: Text("Signup", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
      ),
      body:  browserloaded ? WebViewWidget(
        controller: controller,
      ) : Center(
        child: CircularProgressIndicator(),
    ),
    );
  }
}