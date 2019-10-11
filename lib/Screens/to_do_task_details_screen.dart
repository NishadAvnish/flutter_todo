import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';


class ToDoTaskDetailsScreen extends StatefulWidget {
  static const routeName='/product_detail_screen';
  @override
  _ToDoTaskDetailsScreenState createState() {
    return _ToDoTaskDetailsScreenState();
  }
}

class _ToDoTaskDetailsScreenState extends State<ToDoTaskDetailsScreen> {
  // final _toDoTask = ToDoTask(
  //   id: "id",
  //   title: "Date with Girl",
  //   //subTitle: ""
  //   detail: "Going to have a candle light dinner.",
  //   dateAdded: "9/10/2019",
  //   deadLine: DateTime.now(),
  //   imageUrl:
  //       "http://cupidspulse.com/wp-content/uploads/2011/10/couple-on-a-romantic-date-e1415925732177.jpg",
  // );

  Container _buildText(String text, TextStyle style, double topMargin) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: style,
      ),
      padding: EdgeInsets.only(
        left: 10,
        top: topMargin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)
        .settings
        .arguments as String;
        
    
    final providerid=Provider.of<PagerItemProvider>(context,listen: false).items.firstWhere((prod)=>prod.id==id);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "ToDo Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.longestSide,
        width: MediaQuery.of(context).size.shortestSide,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  providerid.imageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.white70,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                )
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(providerid.isComplete ? "Completed" : "Incomplete"),
                  Switch(
                    value: providerid.isComplete,
                    onChanged: (value){
                      setState(() {
                       providerid.isComplete = value; 
                      });
                    },
                    activeColor: Colors.black,
                  )
                ],
              ),
            ),
            _buildText("Topic:", Theme.of(context).textTheme.title, 10),
            _buildText(providerid.title, null,10),
            _buildText("Date Added:", Theme.of(context).textTheme.title, 20),
            _buildText(providerid.dateAdded.toString(), null,10),
            _buildText("Deadline:", Theme.of(context).textTheme.title,20),
            _buildText(providerid.deadLine.toString(), null,10),
            _buildText("Note:", Theme.of(context).textTheme.title,20),
            _buildText(providerid.detail, null,10),
          ],
        ),
      ),
    );
  }
}
