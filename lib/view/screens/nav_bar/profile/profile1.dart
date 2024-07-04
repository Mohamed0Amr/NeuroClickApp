import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro/view/screens/main_function/Home.dart';
import 'package:neuro/view/screens/nav_bar/profile/ChangeEmail.dart';
import 'package:neuro/view/screens/nav_bar/profile/ChangePassword.dart';
import 'package:neuro/view/screens/nav_bar/profile/EditProfile.dart';
import 'DeleteAccount.dart';
import 'InformationScreen.dart';
import 'widget/profile_menu.dart';

class Profile1 extends StatefulWidget {
  const Profile1({Key? key}) : super(key: key);

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  String? _imageURL;
  String? _displayName;
  String? _userEmail;
  bool _isLoading = true;
  String? downloadURL;
  String? fileName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // _load();
  }

  // Load user profile data from Firestore
  Future<void> _loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Image').doc(userId).get();

        if (snapshot.exists) {
          setState(() {
            _displayName = snapshot.data()?['displayName'];
            _imageURL = snapshot.data()?['profile_image'];
            _userEmail = user.email;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Pick and upload a new profile image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageURL = null;
        _isLoading = true;
      });

      final file = File(pickedFile.path);
      fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('user_images/$fileName')
            .putFile(file);

        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('user_images/$fileName')
            .getDownloadURL();

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userId = user.uid;
          String? userEmail = user.email;
          await FirebaseFirestore.instance
              .collection('Image')
              .doc(userId)
              .set({
            'profile_image': downloadURL,
            'timestamp': Timestamp.now(), // Add timestamp here
            'email': userEmail, // Add user email here
          }, SetOptions(merge: true));

          setState(() {
            _imageURL = downloadURL;
          });
        }
      } catch (e) {
        print('Error uploading image: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToEditProfileScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );

    // Reload user data after returning from EditProfileScreen
    _loadUserData();
    // _load();
  }

  void _navigateToChangeEmailScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangeEmailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headline4,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : _imageURL != null
                              ? Image.network(
                            _imageURL!,
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqSVh59ew2UnDxXnyMlOy1KYGzkJ6-QbvG1sm5o_z5dg&s',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? "User Name",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: 5),
                        Text(
                          _userEmail ?? FirebaseAuth.instance.currentUser?.email ?? "user@example.com",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _navigateToEditProfileScreen,
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              // Menu
              ProfileNameWidget(
                title: 'Information',
                icon: Icons.manage_accounts,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationScreen(),
                    ),
                  );
                },
              ),
              ProfileNameWidget(
                title: 'Change Password',
                icon: Icons.password_outlined,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()),
                  );
                },
              ),
              ProfileNameWidget(
                title: 'Change Email',
                icon: Icons.email_outlined,
                onPress: _navigateToChangeEmailScreen,
              ),
              ProfileNameWidget(
                title: 'Delete Account',
                icon: Icons.delete_outline,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteAccountScreen(),
                    ),
                  );
                },
              ),
              ProfileNameWidget(
                title: 'Log Out',
                icon: Icons.subdirectory_arrow_right_outlined,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  FirebaseAuth.instance.signOut();
                  Get.to(Home());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
