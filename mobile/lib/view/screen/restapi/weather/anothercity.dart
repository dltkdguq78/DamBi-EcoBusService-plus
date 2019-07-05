import 'package:dambi/view/screen/restapi/weather/weather.dart';
import 'package:dambi/view/screen/restapi/dust/dust.dart';
import 'package:flutter/material.dart';

class AnotherCity extends StatefulWidget {
  @override
  _AnotherCityState createState() => _AnotherCityState();
}

class _AnotherCityState extends State<AnotherCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF689F38),
        title:  Text("다른 지역 날씨 정보"),
      ),
      body: _builBody(),
      backgroundColor: Color(0xffaed581),
    );
  }
  _builBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          _buildAnotherWeather("서울", "서울"),
          _buildAnotherWeather("인천", "인천"),
          _buildAnotherWeather("대전", "대전"),
          _buildAnotherWeather("대구", "대구"),
          _buildAnotherWeather("울산", "울산"),
          _buildAnotherWeather("광주", "광주"),
          _buildAnotherWeather("부산", "부산"),
        ],
      ),
    );
  }

  _buildAnotherWeather(String city, String area) {
    DateTime now = DateTime.now();
    String time_now;
    if(now.day < 10) {
      time_now = "${now.year}-0${now.month}-0${now.day} ${now.hour-1}";
    }
    else{
      time_now = "${now.year}-0${now.month}-${now.day} ${now.hour-1}";
    }
    String today_date = "${now.month}월 ${now.day}일";
    double screen_width = MediaQuery.of(context).size.width;


    return Container(
      margin: EdgeInsets.only(
          left: screen_width / 50,
          right: screen_width / 50,
          top: screen_width / 50,
          bottom: screen_width / 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), color: Color(0xffdcedc8)),
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Color(0xffdcedc8),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: screen_width / 10, right: screen_width / 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$today_date $city 기상 정보",
                    style:
                    TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(screen_width / 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Weather(
                    region: city,
                  ),
                  Dust(
                    region: area,
                    timedetail: time_now,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screen_width / 2.5),
              child: Text(
                "업데이트 시간: ${now.hour}시",
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
