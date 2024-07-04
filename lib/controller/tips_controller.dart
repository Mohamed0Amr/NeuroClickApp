import 'package:cloud_firestore/cloud_firestore.dart';

class TipController {
  final CollectionReference tipsCollection =
  FirebaseFirestore.instance.collection('Tips');
  // final _fireStore = FirebaseFirestore.instance;

  Future<String> addTip({
    required String tip,
    required String email,
  }) async {
    try {
      DocumentReference docRef = await tipsCollection.add({
        'description': tip,
        'email':email,
      });
      print("Tip added to Firestore with ID: ${docRef.id}");
      return docRef.id;
    } catch (e) {
      print("Failed to add tip: $e");
      throw e; // Throw error for handling in calling code
    }
  }

  Future<List<Map<String, dynamic>>> tipList() async {
    try {
      QuerySnapshot querySnapshot = await tipsCollection.get();
      List<Map<String, dynamic>> tips = [];
      querySnapshot.docs.forEach((doc) {
        tips.add(doc.data() as Map<String, dynamic>);
      });
      return tips;
    } catch (e) {
      print("Failed to fetch tips: $e");
      throw e; // Throw error for handling in calling code
    }
  }

  Future<void> updateTipCompletion(String tipId, bool isCompleted) async {
    try {
      await tipsCollection.doc(tipId).update({'isComplete': isCompleted});
      print("Tip completion status updated in Firestore");
    } catch (e) {
      print("Failed to update tip completion status: $e");
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getTipById(String tipId) async {
    try {
      DocumentSnapshot docSnapshot = await tipsCollection.doc(tipId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        return null; // Return null if tip with given ID does not exist
      }
    } catch (e) {
      print("Failed to get tip details: $e");
      throw e;
    }
  }
  Future<void> delete(String taskId) async {
    try {
      await tipsCollection.doc(taskId).delete();
      print("Task deleted from Firestore");
    } catch (e) {
      print("Failed to delete task: $e");
      throw e; // Throw error for handling in calling code
    }
  }
}
