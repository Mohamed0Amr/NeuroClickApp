import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-3.dart';
import '../../../../controller/tips_controller.dart';

class question2 extends StatefulWidget {
  const question2({super.key});

  @override
  State<question2> createState() => _question2State();
}

class _question2State extends State<question2> {
  @override
  Widget build(BuildContext context) {
    final userEmailID = FirebaseAuth.instance;
    List<String> answers = [
      "Talk to friends or colleagues",
      "Lisnting Music",
      "Play Youga",
      "Go for a walk",
      "play TeamSport",
      " Break Large Goals to smaller",
      "Sleep about 6 to 8 hours"
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

    List<String> moderate = [
      "Set specific goals for each step",
      " Deep Breathing",
      "Healthy Eating ",
      " Sufficient Sleep",
      "Communication With a new friends",
      " Physical Activity "
    ];

    String modertaeans = '';

    void generateRandomAnswer2() {
      Random random = Random();
      int index = random.nextInt(moderate.length);
      modertaeans = moderate[index];
      TipController().addTip(
        tip: modertaeans,
        email: userEmailID.currentUser?.email ?? '',
      );
    }

    List<String> Severe = [
      "Minimizing distractions in your home\n and workspace.",
      "Noise-canceling headphones",
      " Deep Breath",
      "Playing with your coach"
    ];
    String Severeeans = '';

    void generateRandomAnswer3() {
      Random random = Random();
      int index = random.nextInt(Severe.length);
      Severeeans = Severe[index];
      TipController().addTip(
        tip: Severeeans,
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
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How would you describe the impact of ADHD symptoms on your daily life, including work, school, relationships, and personal activities?",
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 50),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                generateRandomAnswer();
                print(randomAnswer);
                await Get.to(question3(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 180,
                height: 80,
                child: Center(
                  child: Text(
                    'Mild',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                generateRandomAnswer2();
                print(modertaeans);
                await Get.to(question3(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 180,
                height: 80,
                child: Center(
                  child: Text(
                    'Moderate',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                generateRandomAnswer3();
                print(Severeeans);
                await Get.to(question3(), transition: Transition.rightToLeft);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 180,
                height: 80,
                child: Center(
                  child: Text(
                    'Severe',
                    style: TextStyle(
                        fontSize: 20,
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
