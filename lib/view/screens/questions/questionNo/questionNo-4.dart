import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/questions/questionNo/questionNo-5.dart';

class questionNo4 extends StatelessWidget {
  const questionNo4({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Use the Two-Minute Rule",
      " Break Tasks into Smaller Steps",
      "Set Specific Deadlines"
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
      "Learn to Say No",
      " Prioritize Commitments ",
      " Use a Task Management System"
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
      "Use the Eisenhower Matrix",
      "  Establish Clear Goals",
      "Review and Adjust Regularly"
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
      "Create a Distraction-Free Environment",
      "use Time Blocking ",
      "Implement Focus Techniques"
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
                    "What are your main challenges when it comes to managing your time effectively?",
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
                   await Get.to(questionNo5(), transition: Transition.rightToLeft);
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
                        onTap: () {

                        },
                        child: Text(
                          'Procrastination',
                          style:TextStyle(
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
                    await Get.to(questionNo5(), transition: Transition.rightToLeft);
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
                        'Overcommitting',
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

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async{
                    generateRandomAnswer2();
                    print(randomAnswer2);
                    await Get.to(questionNo5(), transition: Transition.rightToLeft);
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
                        'Difficulty prioritizing tasks',
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async{
                    generateRandomAnswer3();
                    print(randomAnswer3);
                    await Get.to(questionNo5(), transition: Transition.rightToLeft);
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
                        'Distractions',
                        style:TextStyle(
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
