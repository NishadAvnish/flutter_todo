import 'package:flutter/material.dart';

import 'profile_screen.dart';
import 'Home.dart';
import 'statistics_screen.dart';

class SelectNavigationScreen extends StatefulWidget {
  @override
  _SelectNavigationScreenState createState() => _SelectNavigationScreenState();
}

class _SelectNavigationScreenState extends State<SelectNavigationScreen> {

  int _selectedIndex = 0;

  final List<Map<String,Object>> _screensList = [
    {
      "title" : "Home",
      "page"  : Home()
    },
    {
      "title" : "Profile",
      "page"  : ProfileScreen()
    },
    {
      "title" : "Statistics",
      "page"  : StatisticsScreen()
    }
  ];

  BottomNavigationBarItem _buildBottomNavigationBarItem(String title, IconData icon){

    return BottomNavigationBarItem(
            icon: Icon(
              icon
            ),
            title: Text(title),
          );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screensList[_selectedIndex]["page"],
      bottomNavigationBar:  BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            _buildBottomNavigationBarItem("Home", Icons.home),
            _buildBottomNavigationBarItem("Profile", Icons.person_outline),
            _buildBottomNavigationBarItem("Statistics", Icons.show_chart),
          ],
        
      ),
    );
  }
}