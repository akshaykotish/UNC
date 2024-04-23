import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unc/BodyParts/BusinessCard.dart';
import 'package:unc/BodyParts/MetaMaskCard.dart';
import 'package:unc/Screens/Splash.dart';

import '../BodyParts/Infocard.dart';
import '../BodyParts/StageCards.dart';
import '../UNCRequest/Dashboard.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HandleDashboardRequest handleDashboardRequest =  HandleDashboardRequest();

  List<String> seedfundparts = <String>[];

  Future<void> ProcessDashboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isavailable = await handleDashboardRequest.RequestDashboardData();
    if(isavailable == false){
      //Navigator.pop(context);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
    }
    else{
      seedfundparts = HandleDashboardRequest.dashboard.seedfunding.split(";");
      setState(() {

      });
    }
  }

  @override
  void initState() {
    ProcessDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
        actions: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("cookies");
              var dd = await prefs.getString("cookies");
              var dsb = await prefs.remove("dashboard");
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, bottom: 20),
                child: Text("Hello " + HandleDashboardRequest.dashboard.FullName + ",", style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.start,),
              ),
              BusinessCardWidget(
                      CardHolderName: HandleDashboardRequest.dashboard.FullName,
              WalletID: HandleDashboardRequest.dashboard.WalletID,
                UserID: HandleDashboardRequest.dashboard.UserID,
              ),
              SizedBox(height: 10,),
              //MetaMaskCard(),
              SizedBox(height: 20,),
              BlurryCard(
                icon: seedfundparts.length > 2 ? seedfundparts[1].contains("Open") ? Icons.trending_up : Icons.curtains_closed_rounded : Icons.token,
                text: seedfundparts.length > 1 ? seedfundparts[0].toString() : "",
                number: seedfundparts.length > 3 ? seedfundparts[2].toString() : "",
                status: seedfundparts.length > 2 ? seedfundparts[1] : "",
                change: seedfundparts.length > 4 ? seedfundparts[3]: "",
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(left: 20, top: 20,),
                width: double.infinity,
                  child: Text("Pre-Launch Stage", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
              ),
              Column(
                children: HandleDashboardRequest.dashboard.pre_launch_stages.map((stageline){
                  var parts = stageline.split(";");
                  return BlurryCard(
                      icon: parts[1].contains("Open") ? Icons.real_estate_agent : Icons.curtains_closed_sharp,
                      text: parts[0],
                      number: parts[5],
                    details: parts[2] + "=" + parts[3],
                    status: parts[1],
                    change: "",
                  );
                }).toList(),
              ),
              SizedBox(height: 20,),
              Container(
                  margin: EdgeInsets.only(left: 20, top: 20,),
                  width: double.infinity,
                  child: Text("User Activities", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
              ),
              Column(
                children: HandleDashboardRequest.dashboard.useractivities.map((activity){
                  var parts = activity.split(";");
                  return BlurryCard(
                    icon: Icons.supervised_user_circle_sharp,
                    text: parts[0],
                    number: parts[1],
                    change: "",
                    details: parts[0],
                    status: parts[1].contains("Inactive") ? "Close" : "Open",
                  );
                }).toList(),
              ),
              SizedBox(height: 20,),
              Container(
                  margin: EdgeInsets.only(left: 20, top: 20,),
                  width: double.infinity,
                  child: Text("Transfers & Token", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
              ),
              Column(
                children: HandleDashboardRequest.dashboard.transferunc.map((transfer){
                  var parts = transfer.split(";");
                  return BlurryCard(
                    icon: Icons.token,
                    text: parts[0],
                    number: parts[2],
                    change: "",
                    details: parts[1],
                    status: parts[1].contains("Inactive") ? "Close" : "Open",
                  );
                }).toList(),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
