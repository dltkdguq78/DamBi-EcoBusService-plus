import 'dart:async';
import 'package:dambi/view/screen/restapi/transtimes/TransTimesInfo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransTimes extends StatelessWidget{
  final Future<TransTimesInfo> transtimesinfo;
  String token;
  static int len;
  @override
  TransTimes({
    Key key,
    this.token,
    this.transtimesinfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<TransTimesInfo>(
          future: getTransTimes(token),
          //sets the getQuote method as the expected Future
          builder: (context, snapshot) {
            if (snapshot.hasData) { //checks if the response returns valid data
              len = snapshot.data.len;
              return Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "${snapshot.data.len}회",
                      style: TextStyle(color: Color(0xffab47bc),fontSize: 20),
                      textScaleFactor: 1.08,
                    ),
                  ],
                ),
              );
            }
            else if (snapshot.hasError) { //checks if the response throws an error
              return Text(
                "0회",
                style: TextStyle(color: Color(0xffab47bc ),fontSize: 20),
                textScaleFactor: 1.08,
              );
            }
            return CircularProgressIndicator();
          },
        )
    );
  }

  Future<TransTimesInfo> getTransTimes(String Token) async {
    String uri = 'http://kumoh42teamcontest.p-e.kr/Bus';

    final response =
    await http.post(uri,
        body: {"token": "$Token"},
        headers: {'Accept': 'application/json'}
    );

    print(response.body);

    if (response.statusCode == 200) {
      return TransTimesInfo.fromJson(json.decode(response.body));
    }
    else {
      throw new Exception();
    }
  }
}