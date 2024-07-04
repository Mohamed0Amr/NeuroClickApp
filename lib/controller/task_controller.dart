import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TaskController {
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('Tasks');
  final _fireStore = FirebaseFirestore.instance;

  Future<String> addTask({
    required String title,
    required String note,
    required String selectedDate,
    required String startTime,
    required String endTime,
    required int selectedRemind,
    required String selectedRepeat,
    required int selectedColor,
    required int isCompleted,
    required String userEmail,
  }) async {
    try {
      DocumentReference docRef = await tasksCollection.add({
        'title': title,
        'note': note,
        'date': selectedDate,
        'startTime': startTime,
        'endTime': endTime,
        'remind': selectedRemind,
        'repeat': selectedRepeat,
        'color': selectedColor,
        'isComplete': 0,
        'userEmail': userEmail
      });
      print("Task added to Firestore with ID: ${docRef.id}");
      return docRef.id;
    } catch (e) {
      print("Failed to add task: $e");
      throw e; // Throw error for handling in calling code
    }
  }

  Future<List<Map<String, dynamic>>> taskList() async {
    try {
      QuerySnapshot querySnapshot = await tasksCollection.get();
      List<Map<String, dynamic>> tasks = [];
      querySnapshot.docs.forEach((doc) {
        tasks.add(doc.data() as Map<String, dynamic>);
      });
      return tasks;
    } catch (e) {
      print("Failed to fetch tasks: $e");
      throw e; // Throw error for handling in calling code
    }
  }

  Future<void> delete(String taskId) async {
    try {
      await tasksCollection.doc(taskId).delete();
      print("Task deleted from Firestore");
    } catch (e) {
      print("Failed to delete task: $e");
      throw e; // Throw error for handling in calling code
    }
  }

  Future<void> updateTaskCompletion(String taskId, int isCompleted) async {
    try {
      await tasksCollection.doc(taskId).update({'isComplete': isCompleted});
      print("Task completion status updated in Firestore");
    } catch (e) {
      print("Failed to update task completion status: $e");
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getTaskById(String taskId) async {
    try {
      DocumentSnapshot docSnapshot = await tasksCollection.doc(taskId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        return null; // Return null if task with given ID does not exist
      }
    } catch (e) {
      print("Failed to get task details: $e");
      throw e;
    }
  }

}
