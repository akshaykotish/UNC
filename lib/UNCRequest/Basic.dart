import 'package:http/http.dart' as http;
import 'dart:math';

class Basic{

  String CSRFTOKEN = "";
  List<String> cookies = <String>[];

  Basic(){
    GetCSRFToken();
    print("Basic Run");
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

  Future<void> Post(surl, sdata, sheaders) async {

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

    // Check the response status code
    if (response.statusCode == 200) {
      // Request was successful
      print('POST request was successful');
      print('Response body: ${response.body}');
    } else {
      // Request failed
      print('POST request failed with status code: ${response.statusCode}');
      print("Reponse body ${response.body}");
    }
  }

  void RequestOTP(userid, password)
  {
    var url = 'https://unicitizens.com/login';
    Map<String, String> data = {
      'user_id': userid,
      'password': password,
      // Add more data as needed
    };
    var headers = {
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie': "XSRF-TOKEN=" + cookies[0] + ";uni_session=" + cookies[1],
      'origin': 'https://unicitizens.com',
      'referer': 'https://unicitizens.com/signin',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
      'x-csrf-token': CSRFTOKEN,
      'x-requested-with': 'XMLHttpRequest',
      'Cookie': "XSRF-TOKEN=" + cookies[0] + ";uni_session=" + cookies[1],
    };
    Post(url, data, headers);
  }

  void RequestLogin(userid, password, otp)
  {
    var url = 'https://unicitizens.com/login';
    Map<String, String> data = {
      'user_id': userid,
      'password': password,
      'otp': otp
      // Add more data as needed
    };
    var headers = {
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie': "XSRF-TOKEN=" + cookies[0] + ";uni_session=" + cookies[1],
      'origin': 'https://unicitizens.com',
      'referer': 'https://unicitizens.com/signin',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
      'x-csrf-token': CSRFTOKEN,
      'x-requested-with': 'XMLHttpRequest',
      'Cookie': "XSRF-TOKEN=" + cookies[0] + ";uni_session=" + cookies[1],
    };
    Post(url, data, headers);
  }

  Future<http.Response> Get(url)
  async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200)
      {
        return response;
      }
    else{
      return http.Response("NotFound", 401);
    }

  }

  Future<void> TryToGetCookies()
  async {
    http.Response response = await Get("https://unicitizens.com/signin");
    var headers = response.headers;

    print(headers);
  }

  Future<void> GetCSRFToken() async {
    http.Response response = await Get("https://unicitizens.com/signin");
    String body = response.body;
    var headers = response.headers;

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
      print(CSRFTOKEN);
    }

    if(headers["set-cookie"] != null)
    {
      String basecookie = headers["set-cookie"].toString();
      //print(basecookie);

      int xsrftindex = basecookie.indexOf("XSRF-TOKEN=") + ("XSRF-TOKEN=").length;
      String xsrftoken = "";



      int indx = xsrftindex;
      while(basecookie[indx] != ";")
        {
          xsrftoken += basecookie[indx];
          indx++;
        }

        print(xsrftoken);
      cookies.add(xsrftoken);

      int unisesindex = basecookie.indexOf("uni_session=") + ("uni_session=").length;
      String unisession = "";
      indx = unisesindex;
      while(basecookie[indx] != ";")
      {
        unisession += basecookie[indx];
        indx++;
      }

      print(unisession);
      cookies.add(unisession);

    }
  }

  Future<void> Run() async {
    GetCSRFToken();
  }
}