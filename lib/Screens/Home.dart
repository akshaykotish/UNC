import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unc/BodyParts/AnimatedBackground.dart';
import 'package:unc/Screens/Dashboard.dart';

import '../BodyParts/FromHex.dart';
import 'Browser.dart';
import 'Menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int AMindex = 0;
  var AllMenues = <Widget>[Dashboard(), AnimatedContainersPage(), WebViewPage(url: "https://unicitizens.com/profile", Title: "Profile")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: AllMenues[AMindex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: ColorFromHexCode("#075985"),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.manage_accounts_sharp, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          AMindex = index;
          print(index);
          setState(() {

          });
        },
      ),
    );
  }
}
