import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/view/screens/main_function/Home.dart';
import 'package:neuro/view/screens/questions/question-1.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-5.dart';
import 'package:neuro/view/screens/questions/questionYes/questionYes-4.dart';

class question4 extends StatefulWidget {
  const question4({Key? key}) : super(key: key);

  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<question4> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;

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
                "What strategies or coping mechanisms have you found effective in managing your ADHD symptoms in various aspects of your life? (Select all that apply)",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              _buildCheckboxItem(
                title: 'Medication',
                isSelected: _isSelected1,
                onTap: () {
                  setState(() {
                    _isSelected1 = !_isSelected1;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Therapy or Counseling',
                isSelected: _isSelected2,
                onTap: () {
                  setState(() {
                    _isSelected2 = !_isSelected2;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Mindfulness Techniques',
                isSelected: _isSelected3,
                onTap: () {
                  setState(() {
                    _isSelected3 = !_isSelected3;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Exercise or physical activity',
                isSelected: _isSelected4,
                onTap: () {
                  setState(() {
                    _isSelected4 = !_isSelected4;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildCheckboxItem(
                title: 'Support groups or peer networks',
                isSelected: _isSelected5,
                onTap: () {
                  setState(() {
                    _isSelected5 = !_isSelected5;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Get.to(question5());
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
