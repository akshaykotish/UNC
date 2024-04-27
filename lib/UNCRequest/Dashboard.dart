import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unc/UNCRequest/Basic.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class Dashboard{
  String FullName = "";
  String WalletID = "12345";
  String ReferNow = "12344";
  String UserID = "24435";

  String seedfunding = "";
  bool sfloaded = false;

  List<String> pre_launch_stages = <String>[];
  bool plsloaded = false;

  List<String> useractivities = <String>[];
  bool usloaded = false;

  List<String> transferunc = <String>[];
  bool tfloaded = false;
}

class HandleDashboardRequest{

  static Dashboard dashboard = Dashboard();

  String body = "";
  Basic basic = Basic();
  Map<String, dynamic> cookies = <String, dynamic>{};


  ExtractUserName(String body){
    var document = parse(body);
    var UserName = document.getElementsByClassName("text-white")[0].text;

    if(UserName != null)
      {
        dashboard.FullName = UserName;
      }

    var WalletID = parse(document.getElementsByClassName("uni-card")[0].innerHtml).getElementsByTagName("input")[0].attributes["value"];
    if(WalletID != null)
    {
      dashboard.WalletID = WalletID;
    }

    var UserID = parse(document.getElementsByClassName("uni-card")[2].innerHtml).getElementsByTagName("h6")[0].text;
    if(UserID != null)
    {
      dashboard.UserID = UserID;
    }


  }

  ExtractSeedFunding(String body){
    if(dashboard.sfloaded == false) {
      var document = parse(body);
      var seedfunddata = parse(
          document.getElementsByClassName("uni-card")[3].innerHtml)
          .getElementsByTagName("h6");

      String title = seedfunddata[0].text;
      String status = seedfunddata[1]
          .text; //.replaceAll("\n", "").replaceAll("  ", "");
      String amount = seedfunddata[2].text;
      String change = seedfunddata[3].text;

      String imagedata = status.toLowerCase().contains("close") ? "seedfundclose" : "seedfundopen";


      print(status + ", " + amount + ", " + change);

      String mydata = title + ";" + status + ";" + amount + ";" + change + ";"  + imagedata;
      if(dashboard.seedfunding.contains(mydata) == false) {
        dashboard.seedfunding = mydata;
      }
      dashboard.sfloaded = true;
    }
  }

  ExtractStages(String body){
    if(dashboard.plsloaded == false) {
      var document = parse(body);
      var stagedata = document.getElementsByClassName("mt-8")[1].innerHtml;
      var unicard = parse(stagedata).getElementsByClassName("uni-card");

      for (int i = 0; i < unicard.length; i++) {
        String title = unicard[i].getElementsByTagName("h5")[0].text;
        String status = unicard[i].getElementsByTagName("h6")[0].text
            .replaceAll("\n", "").replaceAll("  ", "").replaceAll("  ", "");
        String subhead1 = unicard[i].getElementsByTagName("h6")[1].text;
        String subdata1 = unicard[i].getElementsByTagName("h6")[2].text;
        String subhead2 = unicard[i].getElementsByTagName("h6")[3].text;
        String subdata2 = unicard[i].getElementsByTagName("h6")[4].text;
        print(title + " " + status + " " + subhead1 + " " + subdata1 + " " +
            subhead2 + " " + subdata2);

        String imagedata = status.toLowerCase().contains("close") ? "stageclose" : "stageopen";

        String mydata = title + ";" + status + ";" + subhead1 + ";" + subdata1 + ";" +
            subhead2 + ";" + subdata2 + ";" + imagedata;

        if(dashboard.pre_launch_stages.contains(mydata) == false) {
          dashboard.pre_launch_stages.add(mydata);
        }
      }
      dashboard.plsloaded = true;
    }
  }

  ExtractSmallCards(String body){
    if(dashboard.usloaded == false) {
      var document = parse(body);
      var grids = parse(
          document.getElementsByClassName("grid grid-cols-2")[0].innerHtml);
      var cards = grids.getElementsByClassName("uni-card");
      for (int i = 0; i < cards.length; i++) {
        String title = cards[i].getElementsByTagName("h2")[0].text;
        String value = cards[i].getElementsByTagName("h1")[0].text;
        print(title + ";" + value);

        String imagedata =
            title.toLowerCase().contains("status") ? "status" :
            title.toLowerCase().contains("active member") ? "memberactive" :
            title.toLowerCase().contains("inactive member") ? "memberinactive" :
            title.toLowerCase().contains("bonus") ? "bonus" :
            title.toLowerCase().contains("seed") ? "seed" :
            title.toLowerCase().contains("usdt") ? "usdt" :
            title.toLowerCase().contains("status") ? "status" :
            title.toLowerCase().contains("token") ? "token" : "unc";

        String mydata = title + ";" + value + ";" + imagedata;

        if(dashboard.useractivities.contains(mydata) == false) {
          dashboard.useractivities.add(mydata);
        }
      }
      dashboard.usloaded = true;
    }
  }

  ExtractBigCards(String body)
  {
    if(dashboard.tfloaded == false) {
      var document = parse(body);
      var grids = parse(document.getElementsByClassName("grid")[17].innerHtml);
      var cards = grids.getElementsByClassName("uni-card");
      for (int i = 0; i < cards.length; i++) {
        String title = cards[i].getElementsByTagName("h2")[0].text;
        String details = cards[i].getElementsByTagName("h1")[0].text;
        String value = cards[i].getElementsByTagName("h1")[1].text;
        print(title + ";" + details + ";" + value);

        String imagedata =
        title.toLowerCase().contains("status") ? "status" :
        title.toLowerCase().contains("active member") ? "memberactive" :
        title.toLowerCase().contains("inactive member") ? "memberinactive" :
        title.toLowerCase().contains("bonus") ? "bonus" :
        title.toLowerCase().contains("seed") ? "seed" :
        title.toLowerCase().contains("usdt") ? "usdt" :
        title.toLowerCase().contains("status") ? "status" :
        title.toLowerCase().contains("token") ? "token" : "unc";

        String mydata = title + ";" + details + ";" + value + ";" + imagedata;
        if(dashboard.transferunc.contains(mydata) == false) {
          dashboard.transferunc.add(mydata);
        }
      }
    }
  }


  Future<bool> RequestDashboardData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookiesstring = prefs.getString('cookies');

    print("OK");
    if (cookiesstring != null) {
      cookies = json.decode(cookiesstring);
      if (cookies["XSRF-TOKEN"] != null && cookies["uni_session"] != null) {
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
          "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
          "origin": "https://unicitizens.io",
          "referer": "https://unicitizens.io/",
          "intervention": '<https://www.chromestatus.com/feature/5718547946799104>; level="warning"'
        };

        http.Response response = await basic.Get("https://unicitizens.io/dashboard", header: dashboardheader);

        print("DASJJ");
        if (response.statusCode == 200 && response.body.contains("https://unicitizens.io/login") == true) {
          prefs.remove("cookies");
          print("Removed");
          var dd = await prefs.getString("cookies");
          var dsb = await prefs.remove("dashboard");
          print(dd);
          return false;
        }
        else {
          ExtractUserName(response.body);
          ExtractSeedFunding(response.body);
          ExtractStages(response.body);
          ExtractSmallCards(response.body);
          ExtractBigCards(response.body);

          return true;
        }
      }
      else { return false; }
    }
    else {
      return false;
    }
  }

      void ExtractProfileInfo(){

      }
    }