import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../controller/Signup_cubit.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign_up> {
  SignupCubit sc = SignupCubit();

  // Create FocusNodes
  FocusNode emailFocusNode = FocusNode();

  // Track whether the email box is tapped
  bool isEmailBoxTapped = false;

  // Controllers for password fields
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Strings to hold the error messages
  String passwordErrorMessage = '';
  String passwordLengthError = '';
  String passwordCapitalLetterError = '';
  String passwordNumberError = '';

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
            key: sc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Get.isDarkMode
                          ? AssetImage('assets/white.png')
                          : AssetImage('assets/brain_black.png'),
                    ),
                  ),
                ),
                // SizedBox(height: screenHeight * 0.02),
                Text(
                  'HI!\nCreate a new account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                buildTextField(
                  label: 'Name',
                  icon: Icons.account_circle,
                  onSaved: (value) {
                    sc.user.name = value;
                  },
                ),
                buildTextField(
                  label: 'Email',
                  icon: Icons.forward_to_inbox,
                  focusNode: emailFocusNode,
                  autofocus: isEmailBoxTapped,
                  onTap: () {
                    setState(() {
                      isEmailBoxTapped = true;
                    });
                  },
                  onSaved: (value) {
                    sc.user.email = value;
                  },
                ),
                buildPasswordTextField(
                  label: 'Password',
                  controller: passwordController,
                  onSaved: (value) {
                    sc.user.password = value;
                  },
                  onChanged: (value) {
                    setState(() {
                      passwordErrorMessage = '';
                      passwordLengthError = '';
                      passwordCapitalLetterError = '';
                      passwordNumberError = '';
                    });
                  },
                ),
                if (passwordLengthError.isNotEmpty ||
                    passwordCapitalLetterError.isNotEmpty ||
                    passwordNumberError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (passwordLengthError.isNotEmpty)
                          Text(
                            passwordLengthError,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        if (passwordCapitalLetterError.isNotEmpty)
                          Text(
                            passwordCapitalLetterError,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        if (passwordNumberError.isNotEmpty)
                          Text(
                            passwordNumberError,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                buildPasswordTextField(
                  label: 'Confirm Password',
                  controller: confirmPasswordController,
                  onChanged: (value) {
                    setState(() {
                      passwordErrorMessage = '';
                    });
                  },
                ),
                if (passwordErrorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      passwordErrorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      passwordErrorMessage = '';
                      passwordLengthError = '';
                      passwordCapitalLetterError = '';
                      passwordNumberError = '';

                      // Validate password
                      if (passwordController.text.length < 12) {
                        passwordLengthError = 'Password must be at least 12 characters';
                      }
                      if (!RegExp(r'^[A-Z]').hasMatch(passwordController.text)) {
                        passwordCapitalLetterError = 'First character must be uppercase';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(passwordController.text)) {
                        passwordNumberError = 'Password must contain a number';
                      }
                      if (passwordController.text != confirmPasswordController.text) {
                        passwordErrorMessage = 'Passwords do not match';
                      }

                      // If no errors, validate and submit
                      if (passwordLengthError.isEmpty &&
                          passwordCapitalLetterError.isEmpty &&
                          passwordNumberError.isEmpty &&
                          passwordErrorMessage.isEmpty) {
                        if (sc.formKey.currentState!.validate()) {
                          sc.validateAndSubmit(context);
                        }
                      }
                    });
                  },
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(screenWidth * 0.5, 46),
                  ),
                ),
                SizedBox(
                  child: Text("OR",),
                    height: screenHeight * 0.02),
                SignInButton(
                  Buttons.google,
                  text: "Sign Up With Google",
                  onPressed: () => sc.handleGoogleSignUp(context), // Corrected this line
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool autofocus = false,
    void Function()? onTap,
    void Function(String?)? onSaved,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 175, 176, 179),
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
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        onTap: onTap,
        onSaved: onSaved,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: TextStyle(color: Colors.black),
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        style: TextStyle(
          color: Get.isDarkMode ? Colors.black : Colors.black,
        ),
      ),
    );
  }

  Widget buildPasswordTextField({
    required String label,
    required TextEditingController controller,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 175, 176, 179),
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
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: TextStyle(color: Colors.black),
          labelText: label,
          prefixIcon: Icon(
            Icons.password,
            color: Colors.black,
          ),
        ),
        style: TextStyle(
          color: Get.isDarkMode ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}
