import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  final _emailController = TextEditingController();

  // Form Validation
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content:Text("password reset link sent check your Email") ,
            );
          });
    }

    on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content:Text(e.message.toString()) ,
            );
          });
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(227, 249, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(227, 249, 251, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
            onPressed: () {
              // Navigate back to the previous page (login page)
              Navigator.of(context).pop();
            },
          ),
          title: Text('Forgot Password', style: TextStyle(color: Colors.black)),
        ),

        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black), // Set label text color to black
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) => _emailController.text = value!,
                ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: passwordReset,
                    child:Text(
                      'Reset Password',
                      style:TextStyle(fontSize: 17) ,
                    ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(screenWidth * 0.2 , 40),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Center(
                //   child: GestureDetector(
                //     onTap: _navigateToSignIn,
                //     child: RichText(
                //       text: const TextSpan(
                //         text: 'Have an account? ',
                //         style: TextStyle(fontSize: 16,color: Colors.blueGrey),
                //         children: <TextSpan>[
                //           TextSpan(
                //             text: 'Sign In',
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.blue,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Goto SignUp Page
  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        );
  }
}