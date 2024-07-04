import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/Services/firebase_auth.dart';
import 'package:neuro/controller/Login_controller.dart';
import 'package:neuro/view/screens/main_function/Forget_password.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  loginController lc = loginController();
  MyFirebaseAuth mf = MyFirebaseAuth();

  // Create FocusNodes
  FocusNode emailFocusNode = FocusNode();

  // Track whether the email box is tapped
  bool isEmailBoxTapped = false;

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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: lc.formmkey,
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Get.isDarkMode
                          ? AssetImage('assets/white.png')
                          : AssetImage('assets/brain_black.png'),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Color.fromARGB(255, 175, 176, 179),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(1),
                  child: TextFormField(
                    focusNode: emailFocusNode,
                    autofocus: isEmailBoxTapped,
                    onTap: () {
                      setState(() {
                        isEmailBoxTapped = true;
                      });
                    },
                    onSaved: (value) {
                      lc.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Enter your email";
                      print("yes");
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Color.fromARGB(255, 175, 176, 179),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(1),
                  child: TextFormField(
                    onSaved: (value) {
                      lc.password = value;
                    },
                    validator: (value) {},
                    cursorColor: Colors.black,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: () {
                    lc.taplogin(context);
                    // Get.to(profile());
                  },
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        Get.isDarkMode ? Colors.black : Colors.white,
                    backgroundColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(screenWidth * 0.53, 46),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SignInButton(
                  Buttons.google,
                  text: "Sign In With Google",
                  onPressed: lc.handleGoogleSignIn,
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      print('hi');
                      Get.to(ForgotPassword());
                    },
                    child: Text(
                      'Forget Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
