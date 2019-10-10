import 'package:flutter/material.dart';
import 'package:todolist/models/to_do_task.dart';

class ToDoTaskDetailsScreen extends StatefulWidget{
  @override
  _ToDoTaskDetailsScreenState createState() {
    return _ToDoTaskDetailsScreenState();
  }
}

class _ToDoTaskDetailsScreenState extends State<ToDoTaskDetailsScreen>{

  final _toDoTask = ToDoTask(
    id: "id",
    title: "Date with Girl",
    //subTitle: ""
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("data"),
              Switch(

              )
            ],
          )
        ],
      ),
    );
  }
}