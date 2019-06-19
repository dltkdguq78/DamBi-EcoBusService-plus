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
            setCustomStatus(snapshot.data.accesstoken, id);
            return _buildAlert('로그인에 성공하였습니다.');
          }
          else{
            succ_Login = false;
            return _buildAlert('아이디/패스워드를 확인 해주세요');
          }
        } else if (snapshot.hasError) { //checks if the response throws an error
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();},
    )
    );
  }

  setCustomStatus(String accessToken, String id) async {
    SharedPreferences prefs = await _prefs;
    bool resultToken = await prefs.setString('accessToken', accessToken);
    bool resultid = await prefs.setString('id', id);
    if(resultid && resultToken){
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
      throw Text('서버에 연결할 수 없습니다.');
    }
  }

}
