import 'dart:async';
import 'package:dambi/view/screen/restapi/dust/dustinfo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class othercitydust extends StatefulWidget{
  final Future<DustInfo> dustInfo;
  String timedetail;
  String region;
  @override
  State<StatefulWidget> createState() => DustScreenState();

  othercitydust({
    Key key,
    this.region,
    this.timedetail,
    this.dustInfo
  }) : super(key: key);
}
class DustScreenState extends State<othercitydust> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<DustInfo>(
          future: getDust(widget.region, widget.timedetail), //sets the getQuote method as the expected Future
          builder: (context, snapshot) {
            if (snapshot.hasData) { //checks if the response returns valid data
              return Center(
                child: Column(
                  children: <Widget>[
                    _buildDustIfoItem(snapshot.data.pm2, snapshot.data.pm10),
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
  Future<DustInfo> getDust(String region, String timedetail) async {

    String uri = 'http://kumoh42teamcontest.p-e.kr/dust';

    final response =
    await http.post(uri,
        body:{"region": "$region", "time": "$timedetail"},
        headers: {'Accept': 'application/json'}
    );


    if (response.statusCode == 200) {

      return DustInfo.fromJson(json.decode(response.body));
    } else {
      throw new Exception();
    }
  }

  _buildDustIfoItem(String pm2, String pm10){
    String standard = "";
    if(int.tryParse(pm2) <= 15){
      standard = "좋음";
    }
    else if(int.tryParse(pm2) > 15 &&  int.tryParse(pm2) <= 50){
      standard = "보통";
    }
    else if(int.tryParse(pm2) > 50 &&  int.tryParse(pm2) <= 100){
      standard = "나쁨";
    }
    else{
      standard = "매우나쁨";
    }
    double screen_width = MediaQuery.of(context).size.width;
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Color.fromARGB(230, 200, 230, 250), border: Border.all(color:  Color.fromARGB(255, 100, 170, 240), width: 3), ),

      child: Column(
        children: <Widget>[


          _buildDustIcon(standard),

          Column(
            children: <Widget>[
              Text("$standard", style: TextStyle(
                  fontFamily: 'BDfont',
                  fontStyle: FontStyle.normal,
                  fontSize: screen_width/35.0),),
              Text("$pm10 ㎍", style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screen_width/35.0),),

            ],
          ),
        ],
      ),
    );
  }

  _buildDustIcon(String temp){
    switch(temp){
      case '매우나쁨':
        return Image.asset(
          'assets/dusticon/b.png',
          width: 120,
          height: 120,
        );
      case '나쁨':
        return Image.asset(
          'assets/dusticon/s.png',
          width: 30,
          height: 30,
        );
      case '보통':
        return Image.asset(
          'assets/dusticon/m.png',
          width: 30,
          height: 30,
        );
      case '좋음':
        return Image.asset(
          'assets/dusticon/g.png',
          width: 30,
          height: 30,
        );
    }
  }
}