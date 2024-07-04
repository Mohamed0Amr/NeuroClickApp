import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final currentUserEmail = currentUser.email!;
    final currentUserName = currentUser.displayName ?? "User"; // Handle null display name

    return CommunityStatefulWidget(
      currentUserEmail: currentUserEmail,
      currentUserName: currentUserName,
    );
  }
}

class CommunityStatefulWidget extends StatefulWidget {
  final String currentUserEmail;
  final String currentUserName;

  const CommunityStatefulWidget({
    Key? key,
    required this.currentUserEmail,
    required this.currentUserName,
  }) : super(key: key);

  @override
  State<CommunityStatefulWidget> createState() => _CommunityState();
}

class _CommunityState extends State<CommunityStatefulWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Chat Room")
                  .orderBy("TimeStamp", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return _buildPostItem(
                        message: post['Message'],
                        user: post['UserEmail'],
                        name: post['UserName'],
                        currentUserEmail: widget.currentUserEmail,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Write something...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      filled: true,
                      fillColor: Get.isDarkMode ? Colors.black : Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: postMessage,
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Logged in as ${widget.currentUserEmail}",
              style: TextStyle(
                color:Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPostItem({
    required String message,
    required String user,
    required String name,
    required String currentUserEmail,
  }) {
    final isCurrentUser = user == currentUserEmail;

    final userNameColor = isCurrentUser ? Colors.blue : Colors.red;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: userNameColor,
            ),
          ),
          SizedBox(height: 8),
          Text(message ),
          SizedBox(height: 8),
          if (isCurrentUser)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'You',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Chat Room").add({
        'UserEmail': widget.currentUserEmail,
        'UserName': widget.currentUserName,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      }).then((_) {
        textController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post message: $error'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }
}
