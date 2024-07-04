import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/questions/Awesome.dart';

class question8 extends StatelessWidget {
  const question8({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Access to Accommodations",
      "Structured Environment",
      "Supportive Colleagues or Classmates"
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
      "Open Communication",
      "Emotional Support",
      "Shared Responsibilities"
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
      "Understanding Friends",
      "Engaging in ADHD-Friendly Activities",
      "Positive Social Networks",
      "Social Skills Training"
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
      "Regular Exercise Routine",
      "Healthy Diet and Nutrition",
      "Mindfulness and Relaxation Techniques",
      "Professional Mental Health Support",
      "Time Management Tools"
    ];

    String randomAnswer3 = '';

    void generateRandomAnswer3() {
      Random random = Random();
      int index = random.nextInt(answers.length);
      randomAnswer3 = answer2[index];
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
                    "In what areas of your life do you feel most supported in managing your ADHD symptoms, and where do you feel you could benefit from additional support or resources?",
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //SizedBox(height: 50),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
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
                      child: Text('Work or School',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
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
                    height: 80,
                    child: Center(
                      child: Text('Family relationships',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
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
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        child: Text('Personal well-being and self-care',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.black)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    generateRandomAnswer3();
                    print(randomAnswer3);
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
                      child: Text('Social life',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.black)),
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
