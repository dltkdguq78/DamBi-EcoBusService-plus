import 'dart:async';
import 'package:dambi/view/screen/member/login/logininfo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Login extends StatelessWidget {
  String id;
  String ps;
  bool is_Login;

  Login({
    Key key,
    this.id,
    this.ps
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: FutureBuilder<LogInInfo>(
      future: getDust(id, ps), //sets the getQuote method as the expected Future
      builder: (context, snapshot) {
        if (snapshot.hasData) { //checks if the response returns valid data
          return Center(
            child: Column(
              children: <Widget>[

              ],
            ),
          );
        } else if (snapshot.hasError) { //checks if the response throws an error
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();},
    )
    );
  }

  Future<LogInInfo> getDust(String id, String ps) async {

    String uri = 'http://kumoh42teamcontest.p-e.kr/login';

    final response =
    await http.post(uri,
        body:{"id": "$id", "ps": "$ps"},
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
