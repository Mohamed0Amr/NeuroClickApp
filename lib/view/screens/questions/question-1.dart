import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/main_function/Home.dart';
import 'package:neuro/view/screens/questions/question-1.dart';
import 'package:neuro/view/screens/questions/questionNo/questionNo-2.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-2.dart';

class question1 extends StatelessWidget {
  const question1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Colors.blueGrey[900]
          : Color.fromRGBO(227, 249, 251, 1),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode
            ? Colors.blueGrey[900]
            : Color.fromRGBO(227, 249, 251, 1),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Have you ever been formally diagnosed with ADHD by a healthcare professional?",
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Get.to(question2(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 80,
                child: Center(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(questionNo2(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 80,
                child: Center(
                  child: Text(
                    'No',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
