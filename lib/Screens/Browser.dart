import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unc/UNCRequest/Basic.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../BodyParts/AnimatedBackground.dart';


class WebViewPage extends StatefulWidget {

  String url;
  String Title;
  WebViewPage({required this.url, required this.Title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  final String url = 'https://example.com'; // Replace with your URL

  var controller = WebViewController();

  bool browserloaded = false;

  var cookies;
  Basic basic = Basic();

  Future<void> LoadCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookiesstring = prefs.getString('cookies');
    cookies = json.decode(cookiesstring!);
  }

  void BrowserInit(){
  }

  Future<void> Setup() async {
    await LoadCookies();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    var setokay = await controller.runJavaScriptReturningResult("document.cookie='" + "XSRF-TOKEN=${cookies["XSRF-TOKEN"].toString()}" + ";'");
    var setsokay = await controller.runJavaScriptReturningResult("document.cookie='" + "uni_session=${cookies["uni_session"].toString()}" + ";'");


    var dashboardheader = {
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      "accept-language": "en-US,en;q=0.9",
      "cache-control": "no-cache",
      "cookie": "XSRF-TOKEN=${cookies["XSRF-TOKEN"]
          .toString()};uni_session=${cookies["uni_session"].toString()}",
      "pragma": "no-cache",
      "sec-ch-ua": '"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
      "sec-ch-ua-mobile": "?0",
      "sec-ch-ua-platform": "Windows",
      "sec-fetch-dest": 'document',
      "sec-fetch-mode": "navigate",
      "sec-fetch-site": "none",
      "sec-fetch-user": "?1",
      "upgrade-insecure-requests": "1",
      "user-agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1",
      "origin": "https://unicitizens.com",
      "referer": "https://unicitizens.com/",
      "intervention": '<https://www.chromestatus.com/feature/5718547946799104>; level="warning"'
    };
    controller.loadRequest(Uri.parse(widget.url), headers: dashboardheader);

    print("Removing Header");
    controller.setNavigationDelegate(NavigationDelegate(
      onHttpAuthRequest: (httprequest) async {
        await LoadCookies();
        controller.runJavaScript("document.cookie=XSRF-TOKEN=${cookies["XSRF-TOKEN"].toString()}");
        controller.runJavaScript("document.cookie=uni_session=${cookies["uni_session"].toString()}");
      },
      onPageFinished: (url) async {
        String jscode = "document.getElementsByTagName('header')[0].innerHTML = " + '"' + "<div style='display: flex; flex-wrap: wrap; justify-content: center; align-items: center; align-content: center; width: 100%; height: 5vh; overflow: auto; flex-direction: row; color:white; font-weight:600; font-size:10pt;'><img src='https://unicitizens.com/images/logo.png' width='30%' /><div style='width:60%; text-align:right; margin-top:2%; margin-bottom:2%;'>" + widget.Title + "</div></div>" + '"';
        controller.runJavaScript(jscode);
        controller.runJavaScript('document.getElementById("dashboard").style = "linear-gradient(to top, #075985, #0f172a);');
        //controller.runJavaScript("document.getElementById('example_wrapper').style = 'margin-top:20%';");
        var cookies11 = await controller.runJavaScriptReturningResult("document.cookie");
        print("COokies");
        print(cookies11);
        if(cookies11.toString().contains("XSRF-TOKEN") == false)
          {
            var setokay = await controller.runJavaScriptReturningResult("document.cookie='" + "XSRF-TOKEN=${cookies["XSRF-TOKEN"].toString()}" + ";'");
            var setsokay = await controller.runJavaScriptReturningResult("document.cookie='" + "uni_session=${cookies["uni_session"].toString()}" + ";'");
            controller.loadRequest(Uri.parse(widget.url), headers: dashboardheader);
          }
        setState(() {
          browserloaded = true;
        });
      }
    ));

    //http.Response response = await basic.Get("https://unicitizens.com/referral-user", header:dashboardheader);

    // if(response.statusCode == 200)
    //   {
    //     print("Here it is");
    //     controller.loadHtmlString(response.body);
    //   }
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
        title: Text(widget.Title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
      ),
      body: browserloaded ? WebViewWidget(
        controller: controller,

      ) : Container(
        child: AnimatedGradientBackground(child: Center(child: CircularProgressIndicator(color: Colors.white,))),
      ),
    );
  }
}