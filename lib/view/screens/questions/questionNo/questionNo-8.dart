import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/questions/Awesome.dart';

class questionNo8 extends StatelessWidget {
  const questionNo8({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Use Task Management Software",
      " Implement Time Blocking",
      "Set Up Automated Reminders"
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
      " Use a Digital Calendar",
      "Set Boundaries with Scheduling",
      "Integrate All Aspects of Life"
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
      "Prioritize Tasks with the Eisenhower Matrix",
      " Use Mindfulness and Relaxation Apps",
      "Track Your Progress"
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
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "How do you envision utilizing software features for time management and task prioritization in your daily life?",
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
                    await Get.to(Awesome(), transition: Transition.rightToLeft);
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
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'To increase productivity at work or school',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black)
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
                    await Get.to(Awesome(), transition: Transition.rightToLeft);
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
                    height: 98,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'To better balance work, personal life and leisure activities',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black)
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async{
                    generateRandomAnswer2();
                    print(randomAnswer2);
                    await Get.to(Awesome(), transition: Transition.rightToLeft);
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
                        'To reduce stress and overwhelm',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Get.isDarkMode
                                ? Colors.black
                                : Colors.black)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
