import 'package:flutter/material.dart';
import 'package:dambi/view/screen/market/itemList/item_list.dart';

class PointMarketScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PointMaterScreenState();
}

class PointMaterScreenState extends State<PointMarketScreen> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF689F38),
        title: Text("포인트 마켓"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
          )
        ],
      ),
      backgroundColor: Color(0xffaed581),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xffaed581)),
            child: _buildMenuItemsList(),
          ),
        ),
      ],
    );
  }

  _buildMenuItemsList() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10,),
        Center(
          child:Container(
          padding: EdgeInsets.only(left: 12, right: 12, bottom: 3, top: 3),
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            top: 10.0,
            bottom: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF689F38)),
          child: Text("편의점",style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 15),),
        ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width * 0.0023,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return _buildCategoryItems('CU');
          },
        ),
        SizedBox(height: 10,),
        Center(
          child:Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 3, top: 3),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
                top: 10.0,
                bottom: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFF689F38)),
            child: Text("카페",style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 15),),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width * 0.0023,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return _buildCategoryItems('STARBUCKS');
          },
        ),
      ],
    );
  }
  _buildCategoryItems(String company) {
    return InkWell(
      onTap: () => onMarketInfoButtonAction(),
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            top: 10.0,
            bottom: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xffdcedc8)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            onImageSel(company),
            SizedBox(height: 3,),
            Text(company, style: TextStyle(color:Colors.purple,)),
          ],
        ),
      ),
    );
  }

  onImageSel(String company){
    switch (company) {
      case 'CU':
        return Image.asset('assets/ItemMenu/cu.png', width: MediaQuery.of(context).size.width /3, height: MediaQuery.of(context).size.width /4,);
      case 'STARBUCKS':
        return Image.asset('assets/ItemMenu/starbucks.jpg', width: MediaQuery.of(context).size.width /3, height: MediaQuery.of(context).size.width /4,);
    }
  }

  onMarketInfoButtonAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemListScreen()),
    );
  }
}