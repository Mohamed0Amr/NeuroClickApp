import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-8.dart';

class question7 extends StatelessWidget {
  const question7({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Keep a Journal",
      "Analyze Consequences",
      "Set Goals for Improvement"
    ];

    String randomAnswer = '';

    void generateRandomAnswer() {
      Random random = Random();
      int index = random.nextInt(answers.length);
      randomAnswer = answers[index];
      TipController().addTip(
        tip: randomAnswer,
        email: userEmailID.currentUser?.email ?? '',
      );
    }

    List<String> answer = [
      "Talk to a Trusted Friend or Mentor",
      "Join a Support Group",
      "Seek Professional Help"
    ];

    String randomAnswer1 = '';

    void generateRandomAnswer1() {
      Random random = Random();
      int index = random.nextInt(answers.length);
      randomAnswer1 = answer[index];
      TipController().addTip(
        tip: randomAnswer1,
        email: userEmailID.currentUser?.email ?? '',
      );
    }

    List<String> answer1 = [
      "Practice Mindfulness",
      "Use Visual Reminders",
      "Develop a Personal Mantra"
    ];

    String randomAnswer2 = '';

    void generateRandomAnswer2() {
      Random random = Random();
      int index = random.nextInt(answers.length);
      randomAnswer2 = answer1[index];
      TipController().addTip(
        tip: randomAnswer2,
        email: userEmailID.currentUser?.email ?? '',
      );
    }

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "How does ADHD affect your relationships with others, including family, friends, colleagues, and peers?",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //SizedBox(height: 50),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () async{
                generateRandomAnswer();
                print(randomAnswer);
                await Get.to(question8(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 300,
                height: 80,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                      'Strains relationships significantly',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.black : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async{
                generateRandomAnswer1();
                print(randomAnswer1);
                await Get.to(question8(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 300,
                height: 80,
                child: Center(
                  child: Text(
                    'Causes occasional tension',
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
                generateRandomAnswer2();
                print(randomAnswer2);
                Get.to(question8(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 300,
                height: 80,
                child: Center(
                  child: Text(
                    'Minimally affects relationships',
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
