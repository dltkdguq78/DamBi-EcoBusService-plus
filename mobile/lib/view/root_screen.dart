import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/member/login_screen.dart';
import 'screen/market/point_market_screen.dart';
import 'package:dambi/properties/InformationProperties.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:dambi/properties/location.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class RootScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => RootScreenState();

}

class RootScreenState extends State<RootScreen>{

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Position _currentPosition;
  List<Placemark> plackmark;
  String area;
  String city;
  @override
  void initState() {
    _initCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF689F38),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: InkWell(
            onTap: () => scaffoldKey.currentState.openDrawer(),
            child: Icon(Icons.menu, size: 32.0,),
          ),
        ),
        actions: <Widget>[

          _buildCurrentPositionWidget(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.19,)
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
      body: HomeScreen(city: city, area: area,),
      backgroundColor: Color(0xffaed581),
      drawer: _buildDrawer(),
    );
  }

  _buildDrawer(){
    return Drawer(
      child:Container(
        decoration: BoxDecoration(
          color: Color(0xffdcedc8),
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
      InformationProperties.thisid = null;
      print("s");
    }
    else{
      print("f");
    }
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
    InformationProperties.thisid = null;
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
            color: Color(0xffaed581),
          ),
        ),
      );
    }
    else{
      return Container(
        width: double.infinity,
        child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xffaed581),

            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('사용자 정보'),
                  SizedBox(height: 10,),
                  Text(InformationProperties.thisid),
                ]
            )
        ),
      );
    }
  }

  _buildCurrentPositionWidget(){
    if (area == null && city == null){
      area = '네트워크 오류';
      city = '';
    }
    else if(city == null){
      city = area;
    }
    return FutureBuilder<GeolocationStatus>(
      future: Geolocator().checkGeolocationPermissionStatus(),
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == GeolocationStatus.denied) {
          return Text("Access to location denied");
        }
        return InkWell(
          onTap: () => initState(),
          child: Center(
            child: Text("${area} ${city}", textScaleFactor: 2,
                style: TextStyle(
              fontFamily: 'BDfont',
              fontStyle: FontStyle.normal,
            )),
          )
        );
      },
    );

  }

  Future<void> _initCurrentLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _currentPosition = position;
      _loadPlacemark(position);
    });
  }

  _loadPlacemark(Position position) async {
    plackmark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    plackmark.forEach((place){
      ChangeLocation cl = new ChangeLocation();
      setState(() {
        area = cl.regionname(place.administrativeArea);
        city = cl.regionname(place.locality);
      });
    });
  }
}

