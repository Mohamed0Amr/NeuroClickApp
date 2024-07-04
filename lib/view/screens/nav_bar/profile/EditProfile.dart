import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _photoURL; // Store the photo URL fetched from Firestore
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? currentName = user?.displayName;
    _nameController.text = currentName ?? '';

    try {
      String userId = user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (snapshot.exists) {
        setState(() {
          _photoURL = snapshot.data()?['profile_image'];
        });
      }
    } catch (e) {
      print('Error loading profile data: $e');
      // Handle error loading profile data
    }
  }

  Future<void> _updateName() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        // Update the display name in Firebase Authentication
        await user.updateDisplayName(_nameController.text);

        // Update the name in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'displayName': _nameController.text,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent, // Set background color to transparent
                  child: ClipOval(
                    child: _photoURL != null
                        ? Image.network(
                      _photoURL!,
                      fit: BoxFit.cover, // Ensure the image covers the entire CircleAvatar
                      width: 120, // Adjust width to fit the circle properly
                      height: 120, // Adjust height to fit the circle properly
                    )
                        : Icon(
                      Icons.person,
                      size: 120,
                      color: Colors.grey[400],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _updateName,
                  child: _isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
