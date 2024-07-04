import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:neuro/controller/MachineLearningController.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  static const int secondsInMinute = 60;
  static const int workTimeInMinutes = 60;
  int breakTimeInMinutes = 15;

  bool isRunning = false;
  bool isWorkTime = true;
  int totalSecondsRemaining = workTimeInMinutes * secondsInMinute;
  Timer? timer;
  final email = FirebaseAuth.instance.currentUser?.email;
  final ml = MachineLearningController();

  @override
  void initState() {
    super.initState();
    _fetchPrediction();
  }

  void _fetchPrediction() async {
    try {
      String? prediction = await ml.getTimerPrediction(email!);
      if (prediction == "25/5") {
        setState(() {
          totalSecondsRemaining = 25 * secondsInMinute;
          breakTimeInMinutes = 5;
        });
      } else if (prediction == "50/10") {
        setState(() {
          totalSecondsRemaining = 50 * secondsInMinute;
          breakTimeInMinutes = 10;
        });
      } else if (prediction == "60/15") {
        setState(() {
          totalSecondsRemaining = 60 * secondsInMinute;
          breakTimeInMinutes = 15;
        });
      } else {
        print(prediction);
      }
    } catch (e) {
      print('Error fetching prediction: $e');
      Fluttertoast.showToast(
        msg: "Error fetching prediction: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (totalSecondsRemaining > 0) {
          totalSecondsRemaining--;
        } else {
          if (isWorkTime) {
            isWorkTime = false;
            totalSecondsRemaining = breakTimeInMinutes * secondsInMinute;
            Fluttertoast.showToast(
              msg: "Break Time! $breakTimeInMinutes minutes break.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            _resetTimer();
          }
        }
      });
    });
  }

  void _stopTimer() {
    timer?.cancel();
  }

  void _resetTimer() async {
    try {
      String? prediction = await ml.getTimerPrediction(email!);
      setState(() {
        isRunning = false;
        isWorkTime = true;
        if (prediction == "25/5") {
          totalSecondsRemaining = 25 * secondsInMinute;
          breakTimeInMinutes = 5;
        } else if (prediction == "50/10") {
          totalSecondsRemaining = 50 * secondsInMinute;
          breakTimeInMinutes = 10;
        } else if (prediction == "60/15") {
          totalSecondsRemaining = 60 * secondsInMinute;
          breakTimeInMinutes = 15;
        } else {
          totalSecondsRemaining = workTimeInMinutes * secondsInMinute;
        }
        timer?.cancel();
      });
    } catch (e) {
      print('Error fetching prediction: $e');
      Fluttertoast.showToast(
        msg: "Error fetching prediction: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _toggleTimer() {
    setState(() {
      if (isRunning) {
        _stopTimer();
      } else {
        _startTimer();
      }
      isRunning = !isRunning;
    });
  }

  void _skipTimer() {
    setState(() {
      if (isWorkTime) {
        isWorkTime = false;
        totalSecondsRemaining = breakTimeInMinutes * secondsInMinute;
        Fluttertoast.showToast(
          msg: "Skipping to Break Time! $breakTimeInMinutes minutes break.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        isWorkTime = true;
        totalSecondsRemaining = workTimeInMinutes * secondsInMinute;
        Fluttertoast.showToast(
          msg: "Skipping to Work Time! $workTimeInMinutes minutes work.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      timer?.cancel();
      isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ secondsInMinute;
    int remainingSeconds = seconds % secondsInMinute;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progress = (totalSecondsRemaining /
        (isWorkTime
            ? workTimeInMinutes * secondsInMinute
            : breakTimeInMinutes * secondsInMinute));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 140.0,
              lineWidth: 15.0,
              percent: progress,
              center: Text(
                _formatTime(totalSecondsRemaining),
                style: TextStyle(fontSize: 48.0),
              ),
              progressColor: isWorkTime ? Colors.blue : Colors.red,
              backgroundColor: Colors.grey[300]!,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _toggleTimer,
              child: Text(
                isRunning ? 'Pause' : 'Start',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetTimer,
              child: Text('Reset', style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _skipTimer,
              tooltip: 'Skip to Next Phase',
            ),
          ],
        ),
      ),
    );
  }
}
