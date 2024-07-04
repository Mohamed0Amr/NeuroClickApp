import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro/Services/firebase_auth.dart';
import 'package:neuro/view/screens/nav_bar/profile/Profile.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Retrieve user information
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;

    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 249, 251, 1),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  // Display user's name
                  SizedBox(height: screenHeight * 0.18),
                  if (user != null && user!.providerData[0].providerId == 'google.com')
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.09),
                        CircleAvatar(
                          backgroundImage: NetworkImage(user != null ? user!.photoURL! : ''),
                          radius: 40,
                        ),
                        SizedBox(width: screenWidth * 0.40),
                        // Display user's name
                        Text(
                          'Hi ${user!.displayName ?? ""}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),


                  if (user != null && user!.providerData[0].providerId != 'google.com')
                    Row(
                      children: [
                        SizedBox(height: screenHeight * 0.12),
                        SizedBox(width: screenWidth * 0.12),
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[500]),
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.person,color: Colors.white,),
                        ),
                        SizedBox(width: screenWidth * 0.30),
                        Text(
                          'Hi ${user!.displayName ?? ""}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.search,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Search Tasks",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          SizedBox(
            height: screenHeight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Stuff to do",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.4),
                      Column(
                        children: [
                          Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                            size: 50,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(227, 249, 251, 1)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(227, 249, 251, 1),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.016),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.016),
                                    Icon(Icons.timer),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.16),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.016),
                                    Text(
                                      "Time\nManagement",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.08),
                      Column(
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(227, 249, 251, 1)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(227, 249, 251, 1),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.016),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.016),
                                    Icon(Icons.library_add_check_outlined),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.16),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.016),
                                    Text(
                                      "Profile\nSettings",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
