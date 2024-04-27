import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unc/BodyParts/FromHex.dart';

class BusinessCardWidget extends StatefulWidget {

  String CardHolderName = "";
  String WalletID = "";
  String UserID = "";

  BusinessCardWidget({required this.CardHolderName,required this.WalletID,required this.UserID});

  @override
  _BusinessCardWidgetState createState() => _BusinessCardWidgetState();
}

class _BusinessCardWidgetState extends State<BusinessCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  final String referralLink = 'https://unicitizens.io/signup/';

  @override
  void initState() {
    super.initState();
    // Create an animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Define the color animation
    _animation = ColorTween(
      begin: ColorFromHexCode("#075985"),
      end: ColorFromHexCode("#0f172a"),
    ).animate(_controller)
      ..addStatusListener((status) {
        // Toggle between forward and reverse
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              height: 250,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(image: NetworkImage("https://unicitizens.com/images/dashboard/welcome-bg.jpg"), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black54.withOpacity(0.9), BlendMode.dstATop)),
                color: _animation.value,
                  boxShadow: [
                  BoxShadow(color: ColorFromHexCode("#001A33").withOpacity(0.7), blurRadius: 4,),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 200,
                          alignment: Alignment.centerLeft,
                          child: Image.asset("assets/images/logo.png", scale: 7,),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () {
                                // Copy referral link to clipboard
                                Clipboard.setData(
                                  ClipboardData(text: referralLink + widget.UserID.replaceAll("User-ID: ", "")),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Referral link copied to clipboard!'),
                                  ),
                                );
                              }, icon: Icon(Icons.copy, color: Colors.white70)),
                              Text("Refer", style: TextStyle(color: Colors.white70),)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(top: 10,),
                          padding: EdgeInsets.only(left: 5, right: 5,),
                          decoration:BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8)
                          ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.WalletID, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),),
                                IconButton(onPressed: () {
                                  // Copy referral link to clipboard
                                  Clipboard.setData(
                                    ClipboardData(text: widget.WalletID),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Wallet address copied to clipboard!'),
                                    ),
                                  );
                                }, icon: Icon(Icons.copy, color: Colors.black, size: 18,)),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 15, bottom: 0),
                    child: Text("${widget.UserID}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(widget.CardHolderName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset("assets/images/metamask.png", scale: 45,),
                              SizedBox(width: 10,),
                              Text("MetaMask", style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white, fontSize: 12),)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }
}