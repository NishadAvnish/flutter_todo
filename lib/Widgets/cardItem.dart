import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  PageController pageController;
  var currentPage;
  CardItem(this.pageController,this.currentPage);


  @override
  Widget build(BuildContext context) {
    final _height=MediaQuery.of(context).size.longestSide;
    final _width=MediaQuery.of(context).size.shortestSide;


    return  Container(
              height: _height*0.7,
              width: _width,
              child: PageView.builder(
                physics: ClampingScrollPhysics(),
                controller: pageController,
                pageSnapping: true,
                itemBuilder: (context, index) {
                  bool active = index == currentPage;

                  final double blur = active ? 20 : 0;
                  final double offset = active ? 20 : 0;
                  final double top = active ? 100 : 200;

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutQuint,
                    margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("Asset/Image/pic1.jpeg"),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: blur,
                              offset: Offset(offset, offset))
                        ]),
                  );
                },
              ),
            );
  }
}
