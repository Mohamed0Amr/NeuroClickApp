import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String email = currentUser?.email ?? 'No email found';
    String name = currentUser?.displayName ?? 'No name found';

    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        centerTitle: true,
        elevation: 0, // Remove elevation
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(email, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
