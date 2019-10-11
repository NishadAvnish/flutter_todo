
import 'package:flutter/material.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';
import 'package:todolist/Screens/EditUserProduct.dart';

import 'package:provider/provider.dart';
import 'package:todolist/Screens/select_navigation_screen.dart';
import 'package:todolist/Screens/to_do_task_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:PagerItemProvider() ),
        
       
      ],
    

   child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "RobotoCondensed",
       textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold,
                ),
              )
      ),
      home: SelectNavigationScreen(),
      routes: {
                ToDoTaskDetailsScreen.routeName: (context) => ToDoTaskDetailsScreen(),
                NewData.routeName:(context)=>NewData(),
                }
    ),);
  }

}

