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
  final String referralLink = 'https://unicitizens.com/signup/';

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
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: _animation.value,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Image.asset("assets/images/logo.png", scale: 5,),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.UserID,
                        style: TextStyle(fontSize: 10,
                          color: Colors.white,),
                      ),
                      Expanded(
                        child: Text(
                          //'Referral Link: $referralLink',
                          'Refer Now',
                          style: TextStyle(fontSize: 10,
                            color: Colors.white,),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy, color: Colors.white,),
                        onPressed: () {
                          // Copy referral link to clipboard
                          Clipboard.setData(
                            ClipboardData(text: referralLink + widget.UserID.replaceAll("User-ID: ", "")),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Referral link copied to clipboard!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("Wallet ID", style: TextStyle(fontSize: 10, color: Colors.white),),
                  Text(
                    widget.WalletID,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: Colors.yellow,),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.CardHolderName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Image.asset("assets/images/metamask.png", scale: 50,),
                            SizedBox(width: 10,),
                            Text("MetaMask", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),)
                          ],
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}