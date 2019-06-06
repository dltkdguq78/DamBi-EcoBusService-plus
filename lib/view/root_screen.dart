import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/member/login_screen.dart';
import 'screen/market/point_market_screen.dart';
import 'package:dambi/properties/InformationProperties.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class RootScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => RootScreenState();

}

class RootScreenState extends State<RootScreen>{

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> regions = <String>['서울', '경기','인천', '강원', '충남', '대전', '충북', '부산', '울산', '대구', '경북', '경남', '전남', '광주', '전북', '제주', '세종'];
  String selRegion = '서울';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xfff4b183),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: InkWell(
            onTap: () => scaffoldKey.currentState.openDrawer(),
            child: Icon(Icons.menu, size: 32.0,),
          ),
        ),
        actions: <Widget>[
          _buildChoseRegion(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08,)
          ,
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: (){
                print("SEARCH ACTION");
              },
              child: Icon(Icons.search, size: 32.0,),
            ),
          )
        ],
      ),
      body: HomeScreen(region: selRegion,),
      backgroundColor: Color(0xfff8cbad),
      drawer: _buildDrawer(),
    );
  }

  _buildDrawer(){
    return Drawer(
      child:Container(
        decoration: BoxDecoration(
          color: Color(0xfffff2cc),
        ),
      child: Column(
        children: <Widget>[
          _buildLoginHeader(),
          _buildListTile(),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointMarketScreen())),
            title: Text("포인트 마켓"),
          ),
        ],
      ),
      ),
    );
  }

  removeCustomStatus() async {
    SharedPreferences prefs = await _prefs;

    bool result = await prefs.remove('accessToken');

    if(result){
      InformationProperties.ACT = null;
      print("s");
    }
    else{
      print("f");
    }
  }

  _buildChoseRegion(){

    double screen_width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(right: screen_width/6),
      child:DropdownButtonHideUnderline(
        child: DropdownButton(
          iconSize: 30,
          value: selRegion,
          isDense: true,
          onChanged: (String newValue) {
            setState(() {
              selRegion = newValue;
              print(regions);
            });
          },
          items: regions.map((String value){
            return new DropdownMenuItem(
              child: new Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              value: value,
            );
          }).toList(),
        ),
      ),
    );
  }
  _buildListTile(){
    if(InformationProperties.ACT==null || InformationProperties.ACT.isEmpty) {
      return ListTile(
        onTap: () =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen())),
        title: Text("로그인"),
      );
    }
    else{
      return ListTile(
        onTap: () =>Logout(),
        title: Text("로그아웃"),
      );
    }
  }

  Logout(){
    removeCustomStatus();
    InformationProperties.ACT = null;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  _buildLoginHeader(){
    if(InformationProperties.ACT == null) {
      return Container(
        width: double.infinity,
        child: DrawerHeader(
          child: Text('사용자 정보'),
          decoration: BoxDecoration(
            color: Color(0xfff8cbad),
          ),
        ),
      );
    }
    else{
      return Container(
        width: double.infinity,
        child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xfff8cbad),

            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('사용자 정보'),
                  SizedBox(height: 10,),
                  Text(InformationProperties.ACT),
                ]
            )
        ),
      );
    }
  }
}

