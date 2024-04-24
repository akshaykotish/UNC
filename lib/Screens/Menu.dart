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


  Map<String, String> allpagelinks = <String, String>{
    "Direct Team": "https://unicitizens.com/referral-user",
    "Pre Launch Token": "https://unicitizens.com/wallet-to-wallet",
    "Seed Fund Transfer": "https://unicitizens.com/seed-transfer",
    "Pre Launch": "https://unicitizens.com/ico",
    "Seed Funding": "https://unicitizens.com/seed_funding",
    "UNC Wallet": "https://unicitizens.com/unitoken",
    "Referral Income": "https://unicitizens.com/referral-income"
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
        title: Text('Choose the menu', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
      ),
      body: AnimatedGradientBackground(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Image.asset("assets/images/logo.png", fit: BoxFit.contain, scale: 5,),
              ),
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
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: const Icon(
                                Icons.token,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              allpagelinks.entries.elementAt(index).key,
                              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
