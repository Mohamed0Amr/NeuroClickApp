import 'package:flutter/material.dart';

class CommunityPost extends StatelessWidget {
  final String message;
  final String user;
  final String name; // Add this line to accept the user name
  final String currentUserEmail;

  const CommunityPost({
    Key? key,
    required this.message,
    required this.user,
    required this.name, // Add this line to accept the user name
    required this.currentUserEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = user == currentUserEmail;
    EdgeInsetsGeometry margin = isCurrentUser
        ? EdgeInsets.only(left: 250, right: 20, top: 20) // Adjust padding for messages sent by the current user
        : EdgeInsets.only(right: 250, left: 20, top: 20); // Adjust padding for messages received by the current user

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      margin: margin, // Apply padding based on sender or receiver
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      constraints: BoxConstraints(maxWidth: 200), // Apply maximum width constraint
      alignment: isCurrentUser ? Alignment.centerLeft : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name, // Display the user name
            style: TextStyle(color: isCurrentUser ? Colors.blue : Colors.black),
          ),
          const SizedBox(height: 4.0),
          Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
