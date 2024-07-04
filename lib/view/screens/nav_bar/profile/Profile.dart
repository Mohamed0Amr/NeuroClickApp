import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro/Services/utils.dart';
import 'package:neuro/view/screens/main_function/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedImageList = prefs.getStringList('profileImage');
    if (savedImageList != null) {
      final Uint8List savedImage =
          Uint8List.fromList(savedImageList.map((e) => int.parse(e)).toList());
      setState(() {
        _image = savedImage;
      });
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    _saveImage(img);
  }

  Future<void> _saveImage(Uint8List image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<int> imageList = image.toList();
    await prefs.setStringList(
        'profileImage', imageList.map((e) => e.toString()).toList());
  }

  // void saveData() async {
  //   String resp = await StoreData().saveData(file: _image!);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      // backgroundColor: Get.isDarkMode? Colors.blueGrey[900]:Color.fromRGBO(227, 249, 251, 1),
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(227, 249, 251, 1),
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false, // Remove the back icon
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      // ),
      body: ListView(
        children: [
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.09),
              Row(
                children: [
                  if (user != null &&
                      user.providerData[0].providerId == 'google.com')
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(user != null ? user.photoURL! : ''),
                          radius: 50,
                        ),
                        SizedBox(width: screenWidth * 0.28),
                        Text(
                          'HELLO',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  if (user != null &&
                      user.providerData[0].providerId != 'google.com')
                    Row(
                      children: [
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqSVh59ew2UnDxXnyMlOy1KYGzkJ6-QbvG1sm5o_z5dg&s'),
                                  ),
                            Positioned(
                              child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(Icons.add_a_photo),
                              ),
                              bottom: -10,
                              left: 80,
                            )
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.20),
                        Text(
                          'Hi ${user.displayName ?? ""}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
                          Text("Data",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.5),
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
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Profile Settings")],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("${user!.email}")],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        print("Hi");
                      },
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Change Password")],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("${user.phoneNumber}")],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Get.to(Home());
                      },
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOG OUT",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
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
