import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neuro/view/screens/nav_bar/NavigationBar.dart';
import '../Services/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class loginController {
  String? email;
  String? password;
  bool hidden = true;
  GlobalKey<FormState> formmkey = GlobalKey<FormState>();

  void taplogin(BuildContext context) async {
    bool vaild = formmkey.currentState!.validate();
    if (vaild) {
      formmkey.currentState!.save();
      MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
      String? error = await myFirebaseAuth.login(email!, password!);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error"),
            backgroundColor: Colors.red,
          ),
        );
      } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      } else {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Fluttertoast.showToast(
          msg: "Verification email sent. Please verify your email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  void handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Ensure the user is signed out before attempting to sign in again
      await googleSignIn.signOut();

      // Start the Google sign-in process
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          Get.to(() => Navigation());
        }
      }
    } catch (error) {
      print(error);
      // Display a user-friendly message or handle sign-in errors appropriately
      Get.snackbar(
        "Sign-In Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
