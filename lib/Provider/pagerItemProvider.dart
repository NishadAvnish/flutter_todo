import 'package:flutter/material.dart';
import 'package:todolist/models/to_do_task.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagerItemProvider with ChangeNotifier{
  int value=0;
  String name;
  List<String>list1;
  List<ToDoTask> _list = [];

  PagerItemProvider(
    this.list1
    
  );

 void getList(){
    list1!=null?name=list1[value]:name=null;
    
    //just
 }

  void changeValue(value1){
   value=value1;
   fetchShow();
   notifyListeners();
   
    }

    

    // List<ToDoTask> _list=[
    //   ToDoTask(
    //     id:"jsbdjnsbdmncbsmdnc",
    //     title: "School1",
    //     imageUrl:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    //     detail: "THIS IS A TETXT><D>A<M>A<",
    //     dateAdded: DateTime.now(),
    //      deadLine: DateTime.now(),

    //   ),
    //   ToDoTask(
    //     id:"jsbdjnsbc",
    //     title: "School2",
    //     imageUrl:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    //     detail: "THIS IS A TETXT><D>A<M>A<",
    //     dateAdded: DateTime.now(),
    //      deadLine: DateTime.now(),

    //   ),
    //   ToDoTask(
    //     id:"jsmdnc",
    //     title: "School3",
    //     imageUrl:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    //     detail: "THIS IS A TETXT><D>A<M>A<",
    //     dateAdded: DateTime.now(),
    //      deadLine: DateTime.now()

    //   ),
    //   ToDoTask(
    //     id:"bdjnsbdmnnc",
    //     title: "School4",
    //     imageUrl:"https://images.unsplash.com/photo-1570631550965-fe4e7b868d38?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    //     detail: "THIS IS A TETXT><D>A<M>A<",
    //     dateAdded: DateTime.now(),
    //      deadLine: DateTime.now()

    //   )
    // ];
    

    List<ToDoTask> get items{
      return [..._list];  
    }

    ToDoTask findById(String id) {
    return _list.firstWhere((prod) => prod.id == id);
  }

Future<void> addProduct(ToDoTask product,String category) async {
    final String url =
        'https://fluttertodo-49037.firebaseio.com/$category.json';
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
      print(error);
      throw (error);
    }
  }




Future<void> fetchShow() async {
  
    var url ='https://fluttertodo-49037.firebaseio.com/${list1[value]}.json';
    List<ToDoTask> list = [];
    final response = await http.get(url);
    /*print(response.body);*/
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