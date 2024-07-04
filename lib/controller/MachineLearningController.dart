import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MachineLearningController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Predict output based on the given lifestyle choice
  Future<String> predictOutput(BuildContext context, String lifestyleChoice, String email) async {
    Map<String, dynamic> featuresOutput = {
      'Highly structured': 0,
      'Spontaneous': 0,
      'Organized chaos': 0,
    };

    // Update the selected lifestyle choice to 1
    featuresOutput[lifestyleChoice] = 1;

    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.3:6250/predictOutput'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(featuresOutput),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String outputPrediction = data['output'];
        print('Output Prediction: $outputPrediction');

        // Save the prediction to Firestore with email
        await _savePredictionToFirestore('outputPrediction', outputPrediction, email);

        return outputPrediction;
      } else {
        print('Failed response: ${response.body}');
        throw Exception('Failed to predict output');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while predicting output');
    }
  }

  // Predict time based on the given symptoms
  Future<String> predictTime(BuildContext context, List<String> symptoms, String email) async {
    Map<String, dynamic> featuresTime = {
      'Inattention': 0,
      'Impulsivity': 0,
      'Hyperactivity': 0,
      'Difficulty with organization and planning': 0,
    };

    // Update the selected symptoms
    for (String symptom in symptoms) {
      featuresTime[symptom] = 1;
    }

    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.3:6250/predictTime'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(featuresTime),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String timePrediction = data['time'];
        print('Time Prediction: $timePrediction');

        // Save the prediction to Firestore with email
        await _savePredictionToFirestore('timePrediction', timePrediction, email);

        return timePrediction;
      } else {
        print('Failed response: ${response.body}');
        throw Exception('Failed to predict time');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while predicting time');
    }
  }

  // Save prediction to Firestore with email
  Future<void> _savePredictionToFirestore(String predictionType, String prediction, String email) async {
    try {
      await _firestore.collection('ML').add({
        'type': predictionType,
        'prediction': prediction,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      showToast('Prediction saved to Firestore');
    } catch (e) {
      print('Error saving prediction to Firestore: $e');
      showToast('Failed to save prediction to Firestore');
    }
  }

  Future<String?> getTimerPrediction(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('ML')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the latest prediction document
        var predictionDocument = querySnapshot.docs.first.data() as Map<String, dynamic>;
        // Extract and return the prediction value if available, otherwise return null
        return predictionDocument['prediction'] as String?;
      } else {
        throw Exception('No prediction found for the user');
      }
    } catch (e) {
      print('Error fetching prediction: $e');
      throw Exception('Failed to fetch prediction');
    }
  }



  // Show a toast message
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
