import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/questions/questionNo/questionNo-4.dart';

class questionNo3 extends StatelessWidget {
  const questionNo3({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Prioritize Tasks",
      "Break Down Large Tasks",
      " Review and Update Regularly"
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
      "Schedule Specific Time Blocks",
      " Set Reminders and Alerts",
      "Sync Across Devices"
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
      "Utilize Project Management Features",
      "Collaborate with Others ",
      "Integrate with Other Tools"
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

    List<String> answer2 = [
      "use a Bullet Journal",
      " Keep a Master Task List",
      "Regularly Review and Reflect"
    ];

    String randomAnswer3 = '';

    void generateRandomAnswer3() {
      Random random = Random();
      int index = random.nextInt(answers.length);
      randomAnswer3 = answer2[index];
      TipController().addTip(
        tip: randomAnswer3,
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
                    "What methods or tools do you currently use to manage your tasks and prioritize your activities?",
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
                  onTap: () {},
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
                      child: GestureDetector(
                        onTap: () async {
                          generateRandomAnswer();
                          print(randomAnswer);
                          await Get.to(questionNo4(),
                              transition: Transition.rightToLeft);
                        },
                        child: Text(
                          'To-do lists',
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
                  onTap: () async {
                    generateRandomAnswer1();
                    print(randomAnswer1);
                    await Get.to(questionNo4(),
                        transition: Transition.rightToLeft);
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
                      child: GestureDetector(
                        child: Text(
                          'Calendar apps',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    generateRandomAnswer2();
                    print(randomAnswer2);
                    await Get.to(questionNo4(),
                        transition: Transition.rightToLeft);
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
                      child: GestureDetector(
                        child: Text(
                          'Task management software',
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
                  onTap: () async {
                    generateRandomAnswer3();
                    print(randomAnswer3);
                    await Get.to(questionNo4(),
                        transition: Transition.rightToLeft);
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
                      child: GestureDetector(
                        child: Text(
                          'Pen and paper',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
