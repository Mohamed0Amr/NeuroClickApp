import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/controller/MachineLearningController.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-4.dart';

class question3 extends StatefulWidget {
  const question3({Key? key}) : super(key: key);

  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<question3> {
  List<String> selectedSymptoms = [];
  final MachineLearningController mlController = MachineLearningController();

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email!;
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
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Which specific ADHD symptoms do you find most challenging to manage? (Select all that apply)",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              _buildCheckboxItem(
                title: 'Inattention',
                isSelected: selectedSymptoms.contains('Inattention'),
                onTap: () {
                  _handleSymptomSelection('Inattention');
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Hyperactivity',
                isSelected: selectedSymptoms.contains('Hyperactivity'),
                onTap: () {
                  _handleSymptomSelection('Hyperactivity');
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Impulsivity',
                isSelected: selectedSymptoms.contains('Impulsivity'),
                onTap: () {
                  _handleSymptomSelection('Impulsivity');
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Difficulty with organization and planning',
                isSelected: selectedSymptoms
                    .contains('Difficulty with organization and planning'),
                onTap: () {
                  _handleSymptomSelection(
                      'Difficulty with organization and planning');
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Time management difficulties',
                isSelected: selectedSymptoms
                    .contains('Time management difficulties'),
                onTap: () {
                  _handleSymptomSelection('Time management difficulties');
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () async {
                  await mlController.predictTime(context, selectedSymptoms,email!);
                  Get.to(question4());
                },
                child: Text(
                  'NEXT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(screenWidth * 0.3, 46),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSymptomSelection(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  Widget _buildCheckboxItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: isSelected ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 300,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? (Get.isDarkMode ? Colors.black : Colors.white)
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
