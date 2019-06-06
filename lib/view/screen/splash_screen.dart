import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dambi/view/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dambi/properties/InformationProperties.dart';


Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
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

    if(accessToken != null && accessToken.length > 1){
      InformationProperties.ACT = accessToken;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splashlogo.png'),
            fit: BoxFit.cover
        ) ,
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }
}