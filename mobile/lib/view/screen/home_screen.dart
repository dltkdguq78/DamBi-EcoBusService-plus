import 'package:dambi/view/screen/restapi/weather/weather.dart';
import 'package:dambi/view/screen/restapi/dust/dust.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dambi/view/screen/restapi/weather/anothercity.dart';
import 'package:dambi/view/screen/restapi/transtimes/transtimes.dart';
import 'package:dambi/properties/InformationProperties.dart';
import 'package:dambi/view/screen/restapi/transtimes/detailtimes.dart';


class HomeScreen extends StatefulWidget {
  String city;
  String area;

  @override
  State<StatefulWidget> createState() => HomeScreenState();

  HomeScreen({this.city, this.area});
}

class HomeScreenState extends State<HomeScreen> {

  int rideTimesInThisWeek = 7;
  int totalPoint = 1050;


  @override
  Widget build(BuildContext context) {
    return _builBody();
  }

  _builBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildTodaysWeatherWidget(),
          _buildTodaysWeather(),
          _buildAnotherCity(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  _buildTodaysWeatherWidget() {
    double screen_width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          left: screen_width / 50,
          right: screen_width / 50,
          top: screen_width / 50,
          bottom: screen_width / 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), color: Color(0xfffff2cc)),
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Color(0xfffff2cc),
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: screen_width / 10, right: screen_width / 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "마일리지 현황",
                    style: TextStyle(
                      fontFamily: 'BDfont',
                      fontStyle: FontStyle.normal,
                      fontSize: 24
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: 0.5,
                  center: new Text(
                    "50P",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  header: new Text(
                    "오늘 적립 가능 마일리지",
                    style: new TextStyle(
                        fontFamily: 'BDfont',
                        fontStyle: FontStyle.normal,
                         fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Tab(icon: Image.asset('assets/usenumberlogo.png')),
                        SizedBox(
                          width: 10.0,
                        ),
                        AutoSizeText(
                          "대중교통 이용 횟수",
                          style: TextStyle(
                              fontFamily: 'BDfont',
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textScaleFactor: 1.08,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        TransTimes(token: InformationProperties.ACT),
                        SizedBox(width: screen_width/35),
                        _buildDetailButton(),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Tab(icon: Image.asset('assets/pointlogo.png')),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "총 마일리지",
                          style: TextStyle(  fontFamily: 'BDfont',
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textScaleFactor: 1.08,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "${totalPoint}P",
                          style: TextStyle(color: Colors.amber, fontSize: 20.0),
                          textScaleFactor: 1.08,
                        ),
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildTodaysWeather() {
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
          borderRadius: BorderRadius.circular(50.0), color: Color(0xfffff2cc)),
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Color(0xfffff2cc),
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
                    today_date + " 기상 정보",
                    style:
                        TextStyle(  fontFamily: 'BDfont',
                            fontStyle: FontStyle.normal,
                            fontSize: 24.0, ),
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
                    region: widget.city,
                  ),
                  Dust(
                    region: widget.area,
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

  _buildAnotherCity(){
    double screen_width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => onAnotherCityInfoAction(),
      child : Container(
        margin: EdgeInsets.only(
            left: screen_width / 50,
            right: screen_width / 50,
            top: screen_width / 50,
            bottom: screen_width / 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0), color: Color(0xfffff2cc)),
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: Color(0xfffff2cc),
          elevation: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screen_width / 10, right: screen_width / 10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add, size: 20, color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("다른 지역 날씨 상세 정보", style: TextStyle(
                        fontFamily: 'BDfont',
                        fontStyle: FontStyle.normal,
                        fontSize: 20, ),textScaleFactor: 1,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  onAnotherCityInfoAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnotherCity()),
    );
  }

  _buildDetailButton(){
    return InkWell(
      onTap:() =>  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailTimes()),
      ),
      child: Container(
        decoration: BoxDecoration(color: Color(0xfffff2cc), border: Border.all(color: Colors.black, width: 2), ),
        child: Icon(Icons.add, size: 20),
      )
    );
  }
}
