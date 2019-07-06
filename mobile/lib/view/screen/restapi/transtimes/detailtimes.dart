import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:dambi/view/screen/restapi/transtimes/transtimes.dart';
import 'package:dambi/properties/InformationProperties.dart';

class DetailTimes extends StatefulWidget {
  @override
  DetailTimesState createState() => DetailTimesState();
}

class DetailTimesState extends State<DetailTimes> {
  TransTimes tt = new TransTimes(token: InformationProperties.ACT);
  @override
  Widget build(BuildContext context) {
    if(TransTimes.len != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('대중 교통 사용 내역'),
          backgroundColor: Color(0xFF689F38),
        ),
        backgroundColor: Color(0xffdcedc8),
        body: SafeArea(

          child: SectionTableView(
            sectionCount: TransTimes.len,
            numOfRowInSection: (section) {
              return 1;
            },
            cellAtIndexPath: (section, row) {
              return Container(
                padding: EdgeInsets.all(5),
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("사용일시 : ${InformationProperties
                        .translist[section]['사용일시']}"),
                    Text("교통수단 : ${InformationProperties
                        .translist[section]['교통수단']}"),
                    Text("승차역 : ${InformationProperties
                        .translist[section]['승차역']}"),
                    Text("하차역 : ${InformationProperties
                        .translist[section]['하차역']}"),
                    Text("하차일시 : ${InformationProperties
                        .translist[section]['하차일시']}"),
                  ],
                ),
              );
            },
            headerInSection: (section) {
              return Container(
                  padding: EdgeInsets.all(5),
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xffaed581)),
                  child: Center(
                    child: Text('사용 내역 ${section + 1}'),
                  )
              );
            },

            sectionHeaderHeight: (section) => 25.0,
            dividerHeight: () => 1.0,
            cellHeightAtIndexPath: (section, row) => 44.0,
          ),
        ),
      );
    }
    else{
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffdcedc8),
        child : AlertDialog(
          title: Text("알림"),
          content: Text('로그인 해주세요.'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("확인"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
