import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/main_function/Login.dart';
import 'package:neuro/view/screens/main_function/Sign_up.dart';

class Awesome extends StatelessWidget {
  const Awesome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Colors.blueGrey[900]
          : Color.fromRGBO(227, 249, 251, 1),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode
            ? Colors.blueGrey[900]
            : Color.fromRGBO(227, 249, 251, 1),
        elevation: 0.0,
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Awesome!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                Get.to(Login(), transition: Transition.rightToLeft);
              },
              child: Text(
                'Continue',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Get.isDarkMode?Colors.white:Colors.black
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.isDarkMode? Colors.black:Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: Size(screenWidth * 0.4, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
