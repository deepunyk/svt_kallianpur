import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svt_kallianpur/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool check = false;

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No internet connection"),
            content:
                Text("Please switch on your internet connection to proceed."),
            actions: [
              FlatButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("Quit")),
              FlatButton(onPressed: () {}, child: Text("Okay")),
            ],
          );
        });
  }

  checkConnection() async {
    final fbm = FirebaseMessaging();
    fbm.subscribeToTopic('notify');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
    } else {
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!check) {
      check = true;
      checkConnection();
    }

    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.jpg"),
                radius: _mediaQuery.width * 0.15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Shri Venkataramana Temple",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("Kallianpur"),
          ],
        ),
      ),
    );
  }
}
