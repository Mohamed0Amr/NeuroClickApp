import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neuro/view/screens/questions/Intro.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Services/firebase_auth.dart';
import '../model/Client.dart';

class SignupCubit {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Client user = Client();

  void validateAndSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
      try {
        String? error = await myFirebaseAuth.signUp(user.email!, user.password!);
        Navigator.of(context).pop(); // Close the dialog

        if (error == null) {
          FirebaseAuth.instance.currentUser!.updateDisplayName(user.name!);
          Fluttertoast.showToast(
            msg: "The verification email was sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Intro()),
          );
        } else {
          print('Sign up error: $error');
          Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (error) {
        print('Unexpected error during sign up: $error');
        Navigator.of(context).pop(); // Close the dialog
        Fluttertoast.showToast(
          msg: "An unexpected error occurred. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please fill in all the required fields.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // New function for Google Sign-In
  void handleGoogleSignUp(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Ensure the user is signed out before attempting to sign in again
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );

          // Update display name with Google account's display name
          await FirebaseAuth.instance.currentUser!.updateDisplayName(userCredential.user!.displayName);

          Navigator.of(context).pop(); // Close the dialog

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Intro()),
          );
        }
      }
    } catch (error) {
      print('Google sign-in error: $error');
      Fluttertoast.showToast(
        msg: "An error occurred during Google sign-in. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

}
