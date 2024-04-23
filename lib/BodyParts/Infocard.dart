import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unc/BodyParts/FromHex.dart';

class BlurryCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String number;
  final String details;
  final String percentage;
  final String change;
  final double blur;
  final double borderRadius;
  final String status;

  const BlurryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.number,
    this.blur = 100.0,
    this.borderRadius = 9.0,
    this.details = "Look out the changes",
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
      margin: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter:  ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children: <Widget>[
                Container(
                    width: 40,
                    height: 40,
                    child: Icon(icon, size: 30.0, color: status.contains("Open") ? ColorFromHexCode("#E3FFE7") : ColorFromHexCode("#FF4F4F"))),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey.shade200,)),
                            ],
                          ),
                          Text(number, style: TextStyle(fontSize: 14.0, fontWeight: status.contains("Open") ? FontWeight.bold : FontWeight.w400, color: status.contains("Open") ? ColorFromHexCode("#E3FFE7") : ColorFromHexCode("#FF4F4F"),)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(
                           children: <Widget>[
                             SizedBox(width: 5,),
                             Text(details, style: TextStyle(fontSize: 12, color: Colors.grey.shade200),),
                           ],
                         ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.currency_exchange, color: status.contains("Open") ? ColorFromHexCode("#E3FFE7") : ColorFromHexCode("#FF4F4F"), size: 16,),
                              Text(change, style: TextStyle(fontSize: 14.0, color: Colors.grey.shade200, fontWeight: FontWeight.w500,)),
                            ],
                          )
                        ],
                      ),
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
