import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Basic{

  String CSRFTOKEN = "";
  Map<String, String> cookies = <String, String>{};

  Basic(){

  }


  String generateCsrfToken(int length) {
    // Create a secure random generator
    final secureRandom = Random.secure();
    // Define a character set (alphanumeric)
    const String charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    // Generate a secure random string using the character set
    String csrfToken = List.generate(length, (index) {
      return charset[secureRandom.nextInt(charset.length)];
    }).join();

    return csrfToken;
  }

  Future<http.Response> Post(surl, sdata, sheaders) async {

    // The URL you want to send the POST request to
    final url = Uri.parse(surl);

    // The JSON data you want to send in the POST request body
    // final Map<String, dynamic> data = {
    //   'name': 'John Doe',
    //   'email': 'john.doe@example.com',
    //   // Add more data as needed
    // };

    String encodedData = Uri(queryParameters: sdata).query;

    // Make the POST request
    final response = await http.post(
      url,
      body: encodedData,
      headers: sheaders
    );

    //print(response.headers);
    await UpdateTokens(response);
    
    // Check the response status code
    if (response.statusCode == 200) {
      // Request was successful
      print("Su"
          "cessful");
    }
    else {
      // Request failed
      print('${response.statusCode}');
    }
    return response;
  }

  Future<void> RequestOTP(userid, password)
  async {
    print(cookies);
    var url = 'https://unicitizens.com/login';
    Map<String, String> data = {
      'user_id': userid,
      'password': password,
      // Add more data as needed
    };
    var headers = {
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/x-www-form-urlencoded',
      'cookie': "XSRF-TOKEN=${cookies["XSRF-TOKEN"]};uni_session=${cookies["uni_session"]}",
      'origin': 'https://unicitizens.com',
      'referer': 'https://unicitizens.com/signin',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
      'x-csrf-token': CSRFTOKEN,
      'x-requested-with': 'XMLHttpRequest',
      'Cookie': "XSRF-TOKEN=${cookies["XSRF-TOKEN"]};uni_session=${cookies["uni_session"]}",
    };
    var response = await Post(url, data, headers);
    print(response.body);
  }

  Future<bool> RequestLogin(userid, password, otp)
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = 'https://unicitizens.com/login';
    Map<String, String> data = {
      '_token': CSRFTOKEN,
      'user_id': userid,
      'password': password,
      'otp': otp
      // Add more data as needed
    };
    var headers = {
      "accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      //"accept-encoding": "gzip, deflate, br, zstd",
      "accept-language":"en-US,en;q=0.9",
      "cache-control":"no-cache",
      "content-type":"application/x-www-form-urlencoded",
      "cookie":"XSRF-TOKEN=${cookies["XSRF-TOKEN"]};uni_session=${cookies["uni_session"]}",
      "origin":"https://unicitizens.com",
      "pragma":"no-cache",
      "referer":"https://unicitizens.com/signin",
      "sec-fetch-dest":"document",
      "sec-fetch-mode":"navigate",
      "sec-fetch-site":"same-origin",
      "sec-fetch-user":"?1",
      "upgrade-insecure-requests":"1",
      "user-agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1",
    };
    http.Response response = await Post(url, data, headers);
     print("Response of LoginPage");
     print(response.statusCode);
     print(response.body);
     print(response.isRedirect);

     if(response.body.contains("https://unicitizens.com/dashboard")) {

       await prefs.setString('cookies', jsonEncode(cookies));
       await prefs.setString('dashboard', "FOUND");
       return true;

       // print(cookies);
       //
       // var dashboardheader = {
       //   "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
       //   "accept-language": "en-US,en;q=0.9",
       //   "cache-control": "no-cache",
       //   "cookie": "XSRF-TOKEN=${cookies["XSRF-TOKEN"]};uni_session=${cookies["uni_session"]}",
       //   "pragma": "no-cache",
       //   "sec-ch-ua": '"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
       //   "sec-ch-ua-mobile": "?0",
       //   "sec-ch-ua-platform": "Windows",
       //   "sec-fetch-dest": 'document',
       //   "sec-fetch-mode": "navigate",
       //   "sec-fetch-site": "none",
       //   "sec-fetch-user": "?1",
       //   "upgrade-insecure-requests": "1",
       //   "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
       //   "origin": "https://unicitizens.com",
       //   "referer": "https://unicitizens.com/",
       //   "intervention": '<https://www.chromestatus.com/feature/5718547946799104>; level="warning"'
       // };
       //
       // http.Response response1 = await Get(
       //     "https://unicitizens.com/dashboard", header: dashboardheader);
       //
       // print("Response of Dashboard");
       // print(response1.statusCode);
       // print(response1.body.substring(600, 8000));
       // print(response1.isRedirect);
       //
       // if (response1.body.contains("https://unicitizens.com/login")) {
       //   print("Not Found");
       //   return false;
       // }
       // else {
       //   if (response1.body.contains("Shivam")) {
       //     print("Shivam Kumar");
       //   }
       //
       //   print("Found");
       //   return true;
       // }
     }
     else{
       return false;
     }

  }

  Future<http.Response> Get(url, {header})
  async {
    final response = await http.get(Uri.parse(url), headers: header);
    bool allokay = await UpdateTokens(response);
    if(allokay) {
      return response;
    }
    else{
      return response;
    }
  }


  Future<bool> UpdateCSRFToken(String body) async {
    if(body.contains("X-CSRF-TOKEN"))
    {
        int index = body.indexOf("X-CSRF-TOKEN");

        int i = index + ("X-CSRF-TOKEN").length;
        String token = "";
        while(body[i] != ',')
        {
          token += body[i];
          i++;
        }

        token = token.replaceAll('"', "").replaceAll("': ", "");
        CSRFTOKEN = token;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('CSRFToken', CSRFTOKEN);
        return true;
    }
    else{
      return false;
    }
  }

  Future<bool> UpdateCookies(SetCookies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var allcookies = SetCookies.toString().split(",");
    await Future.forEach(allcookies, (cookie) async {
      var cookiesections = cookie.split(";");
      var keyandtoken = cookiesections[0].split("=");
      if(keyandtoken.length == 2) {
      cookies[keyandtoken[0]] = keyandtoken[1];
      var dsb = prefs.getString("dashboard");
      if(dsb == null || dsb != "FOUND") {
        await prefs.setString('cookies', jsonEncode(cookies));
        print("Cookies updated ${cookies}");
      }
      }
    });
    return true;
  }

  Future<bool> UpdateTokens(http.Response response) async {
    bool ucsrftoken = await UpdateCSRFToken(response.body);
    bool uc = await UpdateCookies(response.headers["set-cookie"]);
    if(ucsrftoken && uc) {
      return true;
    }
    else{
      return false;
    }
  }

  void LoadTokens(){
    Get("https://unicitizens.com/signin");
  }

  Future<void> Run() async {
    LoadTokens();
  }
}