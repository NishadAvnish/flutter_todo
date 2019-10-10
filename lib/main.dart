import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Provider/CatergoryProvider.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';

import './Screens/select_navigation_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:CategoryProvider() ),
        
        ChangeNotifierProxyProvider<CategoryProvider,PagerItemProvider>(
            builder: (context,category,previousState)
                {
                return PagerItemProvider(category.items);}
        ),
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
    ),);
  }

}

