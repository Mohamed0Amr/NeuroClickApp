import 'package:firebase_auth/firebase_auth.dart';
class MyFirebaseAuth {
  // Function to sign in with gmail


  // -----------------------------
  // Function for Login
  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return "wrong Email or password";
    } catch (e) {
      return "Try again";
    }
  }

  // ------------------------------
  // Function for Sign Up
  Future<String?> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code.replaceAll('-', ' ');
    } catch (e) {
      return 'Try another time';
    }
  }
}
