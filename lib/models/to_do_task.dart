import 'package:flutter/foundation.dart';

class ToDoTask{
  

  final String id;
  final String title;
  bool isComplete;
  final String detail;
  final String imageUrl;
  String dateAdded;
  String  deadLine;

  ToDoTask({
    @required this.id,
    @required this.title,
    this.isComplete = false,
    @required this.detail,
    @required this.imageUrl,
    @required this.dateAdded,
    @required this.deadLine,
  });

}

