import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';
import 'package:todolist/Widgets/ChoiceChip.dart';
import 'package:todolist/Widgets/cardItem.dart';

import '../Widgets/cardItem.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var currentPage = 0;
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      var next = pageController.page.round();


      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }
  @override
  void didChangeDependencies() {
    Provider.of<PagerItemProvider>(context).getList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _width*0.05,
            top: _height*0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("HEY",style: TextStyle(color: Colors.black26,fontStyle: FontStyle.normal,fontSize: 20)),
                Text("XYZ",style: TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontSize: 30)),

              ],
              
            ),
          ),
         
          Positioned(
            left: 0,
            top: 100,
            child: CardItem(pageController,currentPage)
          ),
          Positioned(
             right: 0,
             bottom: 0,
             left: 0,
            child:ChoiceChipItems()),
        ],
      ),
    );
  }
}
