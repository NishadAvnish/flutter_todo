import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 100,
            child: CardItem(pageController,currentPage)
          ),
        ],
      ),
    );
  }
}
