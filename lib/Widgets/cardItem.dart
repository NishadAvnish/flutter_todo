import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/pagerItemProvider.dart';
import '../Screens/to_do_task_details_screen.dart';

class CardItem extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  CardItem(this.pageController, this.currentPage);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _width = MediaQuery.of(context).size.shortestSide;
    final pagerItem = Provider.of<PagerItemProvider>(context).items;

    List<String> monthList = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return Container(
      height: _height * 0.7,
      width: _width,
      child: PageView.builder(
        controller: pageController,
        pageSnapping: true,
        itemCount: pagerItem.length,
        itemBuilder: (context, index) {
          bool active = index == currentPage;

          final double blur = active ? 20 : 0;
          final double offset = active ? 20 : 0;
          final double top = active ? 100 : 200;

          return GestureDetector(
            onTap: () {
              print("Ontap");
              Navigator.of(context).pushNamed(ToDoTaskDetailsScreen.routeName,
                  arguments: pagerItem[index].id);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutQuint,
              margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(pagerItem[index].imageUrl)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: blur,
                        offset: Offset(offset, offset))
                  ]),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 10,
                      top: 0,
                      child: Icon(
                        Icons.bookmark,
                        size: _height * 0.1,
                        color: Colors.yellow[100],
                      )),
                  Positioned(
                    left: 39,
                    top: 25,
                    child: Column(
                      children: <Widget>[
                        Text(DateTime.parse(pagerItem[index].deadLine)
                            .day
                            .toString()),
                        SizedBox(
                          height: 1,
                        ),
                        Text(monthList[
                            DateTime.parse(pagerItem[index].deadLine).month -
                                1]),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 0,
                    child: Container(
                      height: _height * 0.05,
                      width: _width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white70,
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            pagerItem[index].title.split(' ').first.toString() +
                                "...",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
