import 'dart:core' ;


import 'package:flutter/material.dart';
import 'package:todolist/models/to_do_task.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagerItemProvider with ChangeNotifier{

List<String> _category=[
   "Study",
   "Work",
   "Exercise",
   "Diet",
   "Others",
 ];

 List<String> get categoryItem{
   return [..._category];
 }



  int value=0;
  String name;
  
  List<ToDoTask> _list = [];

  

  void changeValue(value1){
   value=value1;
   fetchShow(categoryItem[value]);
   notifyListeners();
   
    }

    
    
    int get values{
      return value;
    }

    List<ToDoTask> get items{
      return [..._list];  
    }

    ToDoTask findById(String id) {
    return _list.firstWhere((prod) => prod.id == id);
  }

Future<void> addProduct(ToDoTask product) async {
  
    final String url =
        'https://fluttertodo-49037.firebaseio.com/School.json';
    try {
      await http.post(url,
          body: json.encode({
            
            'title': product.title,
            'detail': product.detail,
            'datAdded':product.dateAdded,
            'imageUrl': product.imageUrl,
            'deadLine':product.deadLine,
          }));


      notifyListeners();
    } catch (error) {
      //print(error);
      throw (error);
    }
  }




Future<void> fetchShow([String category]) async {
  var url;
  if(category!=null){
    
    url='https://fluttertodo-49037.firebaseio.com/$category.json';
  }
  else{
   url ='https://fluttertodo-49037.firebaseio.com/School.json';}

   
    List<ToDoTask> list = [];
    final response = await http.get(url);
    //print(response.body); 
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }


    extractedData.forEach((prodId, value) {
      list.add(ToDoTask(
        id: prodId,
        title: value['title'],
        detail: value["detail"],
        imageUrl: value['imageUrl'],
        dateAdded: value['dateAdded'],
        deadLine: value['deadLine']
      ));
    });
    _list = list;
    notifyListeners();
  }

}