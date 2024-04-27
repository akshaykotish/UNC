import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unc/BodyParts/AnimatedBackground.dart';
import 'package:unc/Screens/Browser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedContainersPage(),
    );
  }
}

class AnimatedContainersPage extends StatefulWidget {
  @override
  _AnimatedContainersPageState createState() => _AnimatedContainersPageState();
}

class _AnimatedContainersPageState extends State<AnimatedContainersPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  List<String> images = <String>[
    "assets/uncicons/directteam.png",
    "assets/uncicons/launchtoken.png",
    "assets/uncicons/seedfundtransfer.png",
    "assets/uncicons/prelaunch.png",
    "assets/uncicons/seedfunds.png",
    "assets/uncicons/wallet.png",
    "assets/uncicons/refer.png",
  ];


  Map<String, String> allpagelinks = <String, String>{
    "Direct Team": "https://unicitizens.io/referral-user",
    "Pre Launch Token": "https://unicitizens.io/wallet-to-wallet",
    "Seed Fund Transfer": "https://unicitizens.io/seed-transfer",
    "Pre Launch": "https://unicitizens.io/ico",
    "Seed Funding": "https://unicitizens.io/seed_funding",
    "UNC Wallet": "https://unicitizens.io/unitoken",
    "Referral Income": "https://unicitizens.io/referral-income"
  };

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // Initialize the list of animations with staggered delays
    _animations = List.generate(7, (index) {
      return Tween<Offset>(
        begin: index % 2 == 0 ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      );
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Choose the menu', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
      ),
      body: SingleChildScrollView(
        child: AnimatedGradientBackground(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10
                    ),
                    child: Image.asset("assets/images/logo.png", fit: BoxFit.contain, scale: 5,),
                  ),
                  Text("Choose the preffered option",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return SlideTransition(
                        position: _animations[index],
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPage(url: allpagelinks.entries.elementAt(index).value, Title: allpagelinks.entries.elementAt(index).key)));
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black12),
                              image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(color: Colors.black54.withOpacity(0.5), blurRadius: 1, spreadRadius: 2)
                              ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)
                                    )
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    allpagelinks.entries.elementAt(index).key,
                                    style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 200,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
