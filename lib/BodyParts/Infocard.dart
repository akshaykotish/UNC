import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unc/BodyParts/FromHex.dart';

import 'UNCIcons.dart';

class BlurryCard extends StatelessWidget {
  String iconimage = "";
  final IconData icon;
  final String text;
  final String number;
  final String details;
  final String percentage;
  final String change;
  final double blur;
  final double borderRadius;
  final String status;

  BlurryCard({
    Key? key,
    this.iconimage = "",
    required this.icon,
    required this.text,
    required this.number,
    this.blur = 100.0,
    this.borderRadius = 9.0,
    this.details = "",
    this.percentage = "100%",
    this.change = "100%",
    this.status = "Open",
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorFromHexCode("#0f172a"),
              ColorFromHexCode("#075985"),
            ],
                    ),
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter:  ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: status.contains("Close") ? ColorFromHexCode("797C7C").withOpacity(1) : ColorFromHexCode("#001A33"),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                  image: AssetImage(UNCIcons.images[iconimage].toString()),
            fit: BoxFit.cover,
          )
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(text, style: TextStyle(color: status.contains("Close") ? Colors.white.withOpacity(0.5) : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                      Text(details, style: TextStyle(color: status.contains("Close") ? Colors.white.withOpacity(0.5) :  Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width/5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: status.contains("Close") ? ColorFromHexCode("#5D5D5D").withOpacity(0.5) :  ColorFromHexCode("#00DD65"),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          number.replaceAll(",000,000.00", " M").replaceAll(".00", "").replaceAll("(USDT)", " USDT"),
                          style: TextStyle(
                              color: status.contains("Close") ? Colors.white.withOpacity(0.5) : Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/5,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text(
                            change,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
