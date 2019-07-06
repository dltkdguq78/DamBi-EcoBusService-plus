import 'package:dambi/view/screen/restapi/weather/weather.dart';
import 'package:dambi/view/screen/restapi/weather/othercityweather.dart';
import 'package:dambi/view/screen/restapi/dust/othercitydust.dart';
import 'package:dambi/view/screen/restapi/dust/dust.dart';
import 'package:flutter/material.dart';

class AnotherCity extends StatefulWidget {
  @override
  _AnotherCityState createState() => _AnotherCityState();
}

class _AnotherCityState extends State<AnotherCity> {
  bool firstWidget = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 140, 200, 250),
        title: Text("다른 지역 날씨 정보",
            style: TextStyle(
                fontFamily: 'BDfont',
                fontStyle: FontStyle.normal,
                fontSize: 24)),
      ),
      body: _builBody(),
      backgroundColor: Color.fromARGB(255, 140, 200, 250),
    );
  }

  _builBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[buildItemtab(),

          firstWidget ? _buildAnotherWeather1() : _buildAnotherWeather2(),
         // _buildAnotherWeather2()],
      ],
      ),
    );
  }
  _buildAnotherWeather1() {
    DateTime now = DateTime.now();
    double screen_width = MediaQuery.of(context).size.width;
    double img_width = 400;
    double img_height = 400;
    return Container(
      width: screen_width,
      height: 500,
      margin: EdgeInsets.only(
          left: screen_width / 50,
          right: screen_width / 50,
          top: screen_width / 50,
          bottom: screen_width / 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromARGB(255, 200, 230, 250)),
      padding: EdgeInsets.all(10.0),
      child: Card(
          color: Color.fromARGB(255, 200, 230, 250),
          elevation: 0.0,
          child: Column(children: <Widget>[
            Text(
              "오늘의 전국 날씨",
              style: TextStyle(
                  fontFamily: 'BDfont',
                  fontStyle: FontStyle.normal,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: img_width,
              height: img_height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: ExactAssetImage(
                      'assets/map.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  color: Color.fromARGB(255, 200, 230, 250)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: img_height / 10.0,
                    left: img_width / 3.75,
                    child: _buildCityWeather("서울", "서울"),
                  ),
                  Positioned(
                    top: img_height / 7.0,
                    left: img_width / 8,
                    child: _buildCityWeather("인천", "인천"),
                  ),
                  Positioned(
                    top: img_height / 2.65,
                    left: img_width / 3.75 - 20,
                    child: _buildCityWeather("대전", "대전"),
                  ),
                  Positioned(
                    top: img_height / 2.75,
                    left: img_width / 1.9 - 20,
                    child: _buildCityWeather("대구", "대구"),
                  ),
                  Positioned(
                    top: img_height / 2.3,
                    left: img_width / 1.5 - 20,
                    child: _buildCityWeather("울산", "울산"),
                  ),
                  Positioned(
                    top: img_height / 1.75,
                    left: img_width / 4,
                    child: _buildCityWeather("광주", "광주"),
                  ),
                  Positioned(
                    top: img_height / 1.8,
                    left: img_width / 1.8 - 30,
                    child: _buildCityWeather("부산", "부산"),
                  ),
                  Positioned(
                    top: img_height / 1.25,
                    left: img_width / 3,
                    child: _buildCityWeather("제주", "제주"),
                  ),
                  Positioned(
                    top: img_height / 6.5,
                    left: img_width / 2.5,
                    child: _buildCityWeather("원주", "원주"),
                  ),
                  Positioned(
                    top: img_height / 16.5,
                    left: img_width / 1.75 - 15,
                    child: _buildCityWeather("강릉", "강릉"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      "업데이트 시간: ${now.hour}시",
                      style: TextStyle(
                          fontFamily: 'BDfont',
                          fontStyle: FontStyle.normal,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }
  _buildAnotherWeather2() {
    DateTime now = DateTime.now();
    double screen_width = MediaQuery.of(context).size.width;
    double img_width = 400;
    double img_height = 400;
    return Container(
      width: screen_width,
      height: 500,
      margin: EdgeInsets.only(
          left: screen_width / 50,
          right: screen_width / 50,
          top: screen_width / 50,
          bottom: screen_width / 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromARGB(255, 200, 230, 250)),
      padding: EdgeInsets.all(10.0),
      child: Card(
          color: Color.fromARGB(255, 200, 230, 250),
          elevation: 0.0,
          child: Column(children: <Widget>[
            Text(
              "오늘의 미세먼지",
              style: TextStyle(
                  fontFamily: 'BDfont',
                  fontStyle: FontStyle.normal,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: img_width,
              height: img_height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: ExactAssetImage(
                      'assets/map.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  color: Color.fromARGB(255, 200, 230, 250)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: img_height / 10.0,
                    left: img_width / 3.75,
                    child: _buildCityDust("서울", "서울"),
                  ),
                  Positioned(
                    top: img_height / 7.0,
                    left: img_width / 8,
                    child: _buildCityDust("인천", "인천"),
                  ),
                  Positioned(
                    top: img_height / 2.65,
                    left: img_width / 3.75 - 20,
                    child: _buildCityDust("대전", "대전"),
                  ),
                  Positioned(
                    top: img_height / 2.75,
                    left: img_width / 1.9 - 20,
                    child: _buildCityDust("대구", "대구"),
                  ),
                  Positioned(
                    top: img_height / 2.3,
                    left: img_width / 1.5 - 20,
                    child: _buildCityDust("울산", "울산"),
                  ),
                  Positioned(
                    top: img_height / 1.75,
                    left: img_width / 4,
                    child: _buildCityDust("광주", "광주"),
                  ),
                  Positioned(
                    top: img_height / 1.8,
                    left: img_width / 1.8 - 30,
                    child: _buildCityDust("부산", "부산"),
                  ),
                  Positioned(
                    top: img_height / 1.25,
                    left: img_width / 3,
                    child: _buildCityDust("제주", "제주"),
                  ),
                  Positioned(
                    top: img_height / 6.5,
                    left: img_width / 2.5,
                    child: _buildCityDust("원주", "강원"),
                  ),
                  Positioned(
                    top: img_height / 16.5,
                    left: img_width / 1.75 - 15,
                    child: _buildCityDust("강릉", "강원"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      "업데이트 시간: ${now.hour}시",
                      style: TextStyle(
                          fontFamily: 'BDfont',
                          fontStyle: FontStyle.normal,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }
  _buildCityDust(String city, String area) {
    String time_now;
    DateTime now = DateTime.now();

    if (now.day < 10) {
      time_now = "${now.year}-0${now.month}-0${now.day} ${now.hour - 1}";
    }
    else {
      time_now = "${now.year}-0${now.month}-${now.day} ${now.hour - 1}";
    }
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$city",
              style: TextStyle(
                  fontFamily: 'BDfont',
                  fontStyle: FontStyle.normal,
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .width / 25.0),
            ),
            othercitydust(
              region: "$area",
              timedetail: time_now,
            ),

          ],
        ),
      );
    }
    _buildCityWeather(String city, String area) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$city",
              style: TextStyle(
                  fontFamily: 'BDfont',
                  fontStyle: FontStyle.normal,
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .width / 25.0),
            ),
            othercityweather(
              region: "$city",
            ),
          ],
        ),
      );
    }

    buildItemtab() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              height: 30,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: RaisedButton(
                elevation: 2,
                color: Color.fromARGB(255, 200, 230, 250),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: new Text(
                  "날씨",
                  style: new TextStyle(
                    fontFamily: 'BDfont',
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    firstWidget = true;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              height: 30,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: RaisedButton(
                elevation: 2,
                color: Color.fromARGB(255, 200, 230, 250),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10)),
                child: new Text(
                  "미세먼지",
                  style: new TextStyle(
                    fontFamily: 'BDfont',
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    firstWidget = false;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }
