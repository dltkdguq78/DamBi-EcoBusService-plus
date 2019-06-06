import 'dart:async';
import 'package:dambi/view/screen/member/login/logininfo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dambi/properties/InformationProperties.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class Login extends StatelessWidget {
  String id;
  String ps;
  bool succ_Login;

  Login({
    Key key,
    this.id,
    this.ps
  }) : super(key: key);

  bool getter(){
    return succ_Login;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: FutureBuilder<LogInInfo>(
      future: getInfo(id, ps), //sets the getQuote method as the expected Future
      builder: (context, snapshot) {
        if (snapshot.hasData) { //checks if the response returns valid data
          if(snapshot.data.result == "success"){
            succ_Login = true;
            InformationProperties.ACT = snapshot.data.accesstoken;
            setCustomStatus(snapshot.data.accesstoken);
            return _buildAlert(snapshot.data.accesstoken);
          }
          else{
            succ_Login = false;
            return _buildAlert(snapshot.data.info);
          }
        } else if (snapshot.hasError) { //checks if the response throws an error
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();},
    )
    );
  }

  setCustomStatus(String accessToken) async {
    SharedPreferences prefs = await _prefs;
    bool result = await prefs.setString('accessToken', accessToken);
    if(result){
      print("s");
    }
    else{
      print("f");
    }
  }

  _buildAlert(String str) {
    return Text(
        "Access Token : $str"
    );
  }

  Future<LogInInfo> getInfo(String id, String ps) async {
    String uri = 'http://kumoh42teamcontest.p-e.kr/login';
    final response =
    await http.post(uri,
        body:{"id": "$id", "idpass": "$ps"},
        headers: {'Accept': 'application/json'}
    );

    print(response.body);

    if (response.statusCode == 200) {

      return LogInInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}
