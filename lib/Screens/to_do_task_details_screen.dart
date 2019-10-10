import 'package:flutter/material.dart';

import '../models/to_do_task.dart';

class ToDoTaskDetailsScreen extends StatefulWidget {
  @override
  _ToDoTaskDetailsScreenState createState() {
    return _ToDoTaskDetailsScreenState();
  }
}

class _ToDoTaskDetailsScreenState extends State<ToDoTaskDetailsScreen> {
  final _toDoTask = ToDoTask(
    id: "id",
    title: "Date with Girl",
    //subTitle: ""
    detail: "Going to have a candle light dinner.",
    dateAdded: DateTime.now().toIso8601String(),
    deadLine: DateTime.now().toIso8601String(),
    imageUrl:
        "http://cupidspulse.com/wp-content/uploads/2011/10/couple-on-a-romantic-date-e1415925732177.jpg",
  );

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "ToDo Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                _toDoTask.imageUrl,
                fit: BoxFit.cover,
                height: 250,
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
                Text(_toDoTask.isComplete ? "Completed" : "Incomplete"),
                Switch(
                  value: _toDoTask.isComplete,
                  onChanged: (value){
                    setState(() {
                     _toDoTask.isComplete = value; 
                    });
                  },
                  activeColor: Colors.black,
                )
              ],
            ),
          ),
          _buildText("Topic:", Theme.of(context).textTheme.title, 10),
          _buildText(_toDoTask.title, null,10),
          _buildText("Date Added:", Theme.of(context).textTheme.title, 20),
          _buildText(_toDoTask.dateAdded, null,10),
          _buildText("Deadline:", Theme.of(context).textTheme.title,20),
          _buildText(_toDoTask.deadLine, null,10),
          _buildText("Note:", Theme.of(context).textTheme.title,20),
          _buildText(_toDoTask.detail, null,10),
        ],
      ),
    );
  }
}
