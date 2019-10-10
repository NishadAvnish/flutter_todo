

import 'package:flutter/material.dart';
import 'package:todolist/models/to_do_task.dart';

class CategoryProvider with ChangeNotifier{

 List<String> category=[
   "School",
   "Work",
   "Exercise",
   "Diet",
    
 ];

 List<String> get items{
    return [...category];
 }

}