import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/nav_bar/CalendarAll/Calendar.dart';
import 'package:neuro/view/screens/nav_bar/Camera/Camera.dart';
import 'package:neuro/view/screens/nav_bar/StopWatch/StopWatch.dart';
import 'package:neuro/view/screens/nav_bar/profile/profile1.dart';
import 'package:neuro/view/screens/nav_bar/chat_room/Community.dart';


class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.theme.backgroundColor,
        type: BottomNavigationBarType.fixed, // Disable animation
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat Room',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Get.isDarkMode
            ? Colors.blueGrey[200]
            : Colors.black, // Set unselected item color to black
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return calendar();
      case 1:
        return Camera();
      case 2:
        return Community();
      case 3:
        return StopWatch();
      case 4:
        return Profile1();
      default:
        return Container();
    }
  }
}
