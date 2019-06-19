import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dambi/view/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dambi/properties/InformationProperties.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool isConnected = true;
  @override
  void initState() {
    super.initState();
    checkConnected();
    loadCustomStatus();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {

    Route route = MaterialPageRoute(builder: (context) => RootScreen());
    Navigator.pushReplacement(context, route);
  }

  loadCustomStatus() async {
    SharedPreferences prefs = await _prefs;

    String accessToken = await prefs.getString('accessToken');
    String id = await prefs.getString('id');

    if(accessToken != null && accessToken.length > 1){
      InformationProperties.ACT = accessToken;
      InformationProperties.thisid = id;
    }
  }
  checkConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isConnected = true;
        print("aa");
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnected = true;
        print("bb");
      });
    }
    else{
      setState(() {
        isConnected = false;
        print("cc");
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    if(isConnected) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splashlogo.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        ),
      );
    }
    else{
      return AlertDialog(
        title: Text("알림"),
        content: Text('네트워크에 연결해주세요.'),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("확인"),
            onPressed: () => exit(0),
          ),
        ],
      );
    }
  }
}