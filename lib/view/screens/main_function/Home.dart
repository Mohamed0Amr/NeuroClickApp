import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/questions/Intro.dart';
import 'package:neuro/view/screens/main_function/Login.dart';
import 'package:neuro/view/screens/main_function/Sign_up.dart';
import 'package:neuro/view/screens/nav_bar/profile/Profile.dart';

import '../nav_bar/CalendarAll/Notification_service.dart';
import '../nav_bar/CalendarAll/theme_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var notifyHelper ;

  @override
  void initState(){
    setState(() {

    });
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      // backgroundColor: Get.isDarkMode? Colors.blueGrey[900]:Color.fromRGBO(227, 249, 251, 1),
      appBar: _appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.28,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Get.isDarkMode? AssetImage('assets/white.png')
                      :AssetImage('assets/brain_black.png'),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.001),
            ElevatedButton(
              onPressed: () {
                Get.to(Login());
              },
              child: Text(
                'LOG IN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ,
                    color: Get.isDarkMode? Colors.black:Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.isDarkMode? Colors.white:Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(screenWidth * 0.6, 46),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                // Get.to(Intro());
                Get.to(Sign_up());
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                    color: Get.isDarkMode? Colors.black:Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Get.isDarkMode? Colors.black:Colors.white,
                backgroundColor: Get.isDarkMode? Colors.white:Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(screenWidth * 0.6, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      // backgroundColor: Get.isDarkMode? Colors.blueGrey[900]:Color.fromRGBO(227, 249, 251, 1),
      leading: GestureDetector(
        onTap: () {
          setState(() {

          });
          print('Theme Change');
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme changed",
              body: Get.isDarkMode?"Activated Light" : "Activated Dark");

          // Change the theme instantly
          Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 30,top: 33),
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

}
