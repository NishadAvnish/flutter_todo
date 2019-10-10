import 'package:flutter/material.dart';
import 'package:todolist/models/to_do_task.dart';

class PagerItemProvider with ChangeNotifier{
  int value=0;
  String name;
  List<String>list1;
  PagerItemProvider(
    this.list1
    
  );

 void getList(){
    list1!=null?name=list1[value]:name=null;
    
    //just
 }

  void changeValue(value1){
   value=value1;
   getList();
   notifyListeners();
   print(list1[value]);
    }

    

    List<ToDoTask> _list=[
      ToDoTask(
        id:"jsbdjnsbdmncbsmdnc",
        title: "School1",
        image:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         deadLine: DateTime.now(),

      ),
      ToDoTask(
        id:"jsbdjnsbdmncbsmdnc",
        title: "School2",
        image:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         deadLine: DateTime.now(),

      ),
      ToDoTask(
        id:"jsbdjnsbdmncbsmdnc",
        title: "School3",
        image:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         deadLine: DateTime.now(),

      ),
      ToDoTask(
        id:"jsbdjnsbdmncbsmdnc",
        title: "School4",
        image:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         deadLine: DateTime.now(),

      )
    ];
    

    List<ToDoTask> get items{
      return [..._list];  
    }

    


}