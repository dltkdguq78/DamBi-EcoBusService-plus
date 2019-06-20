import 'dart:async';
import 'package:dambi/view/screen/restapi/weather/weatherinfo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Weather extends StatefulWidget{
  final Future<WeatherInfo> waetherinfo;
  int time;
  String region;
  @override
  State<StatefulWidget> createState() => WeatherScreenState();

  Weather({
    Key key,
    this.region,
    this.waetherinfo
  }) : super(key: key);
}
class WeatherScreenState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<WeatherInfo>(
          future: getWeather(widget.region), //sets the getQuote method as the expected Future
          builder: (context, snapshot) {
            if (snapshot.hasData) { //checks if the response returns valid data
              return Center(
                child: Column(
                  children: <Widget>[
                    _buildTodaysWeatherItem(snapshot.data.tem, snapshot.data.wind, snapshot.data.weather),
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
  Future<WeatherInfo> getWeather(String region) async {

    String uri = 'http://kumoh42teamcontest.p-e.kr/weather';

    final response =
    await http.post(uri,
        body:{"region": "$region"},
        headers: {'Accept': 'application/json'}
    );


    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(json.decode(response.body));
    } else {
      throw new Exception();
    }
  }

  _buildTodaysWeatherItem(String temp, String wind, String weather){
    double screen_width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: screen_width/30.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Color(0xfffff2cc), border: Border.all(color: Color(0xfff4b183), width: 3), ),
        padding: EdgeInsets.only(top: screen_width/25.0, left: screen_width/15.0, right: screen_width/15.0, bottom: screen_width/25.0),
      child: Column(
          children: <Widget>[
            Text("WEATHER",style: TextStyle(fontSize: screen_width/25.0),),
            Padding(
              padding:EdgeInsets.all(10),
              child:_buildWetherIcon(weather),
            ),
            Column(
              children: <Widget>[
                Text("$weather", style: TextStyle(fontSize: screen_width/25.0),),
                Text("$temp ℃", style: TextStyle(fontSize: screen_width/25.0),),
                Text("$wind m/s", style: TextStyle(fontSize: screen_width/25.0),),
              ],
            ),
          ],
      ),
    ),
    );
  }

  _buildWetherIcon(String temp){
    if(temp == '구름조금' || temp == '구름많음' || temp == '흐림') {
      return Icon(Icons.cloud, size: 46.0, color: Colors.blueGrey);
    }
    else if(temp == '박무' || temp == '연무' || temp == '맑음') {
      return Icon(Icons.wb_sunny, size: 46.0, color: Colors.deepOrangeAccent);
    }
    else if(temp == '비'||temp == '뇌우끝,비' ||temp == '약한비계속' ) {
      return Icon(Icons.beach_access, size: 46.0, color: Colors.lightBlue);
    }
    else if(temp == '눈') {
      return Icon(Icons.wb_sunny, size: 46.0, color: Colors.deepOrangeAccent);
    }
  }
}