import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class MetaMaskCard extends StatelessWidget {
  // Function to open the MetaMask app
  void _openMetaMaskApp() async {
    const url = 'https://metamask.app.link/';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   // Handle the error gracefully if the URL can't be launched
    //   print('Could not launch the MetaMask app.');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: _openMetaMaskApp, // Call the function when tapped
          child: Container(
            width: 300,
            padding: EdgeInsets.all(12.0),
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add the MetaMask logo from assets
                Image.asset(
                  'assets/images/metamask.png', // Path to the MetaMask logo image
                  width: 30.0, // Width of the logo
                  height: 30.0, // Height of the logo
                ),
                SizedBox(width: 12.0),
                Text("Powered By ", style: TextStyle(color: Colors.grey),),
                // Add text description
                Text(
                  'MetaMask',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
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