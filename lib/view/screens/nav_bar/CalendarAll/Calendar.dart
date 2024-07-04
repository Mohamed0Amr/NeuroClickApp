import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:neuro/controller/task_controller.dart';
import 'package:neuro/controller/tips_controller.dart';
import 'package:neuro/view/screens/nav_bar/CalendarAll/FunctionCalendar.dart';
import 'package:neuro/view/screens/nav_bar/Task/add_task.dart';
import 'package:neuro/view/screens/nav_bar/Task/button.dart';
import 'package:neuro/view/screens/questions/tip/tipWidegt.dart';
import '../Task/TaskWidget.dart';
import 'Notification_service.dart';
import 'theme_services.dart';

class calendar extends StatefulWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<calendar> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  final _tipController = Get.put(TipController());
  var notifyHelper;

  final userEmailID = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    // NotifyHelper().initializeNotification();
    // NotifyHelper().requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      // backgroundColor: Get.isDarkMode? Colors.blueGrey[900]:Color.fromRGBO(227, 249, 251, 1),
      body: Column(
        children: [
          _appBar(),
          _addTaskBar(),
          _addDateBar(),
          _showTasksAndTips(),
        ],
      ),
    );
  }

  _showTasksAndTips() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Tips').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final tips = snapshot.data!.docs;
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: _taskController.taskList(),
              builder: (context, taskSnapshot) {
                if (taskSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (taskSnapshot.hasError) {
                  return Text('Error: ${taskSnapshot.error}');
                } else {
                  List<Map<String, dynamic>> tasks = taskSnapshot.data!;
                  // Get the email of the logged-in user
                  String currentUserEmail = userEmailID.currentUser?.email ?? '';
                  // Combine tips and tasks data here
                  List<Widget> combinedData = [];
                  combinedData.addAll(tips
                      .where((tip) => tip['email'] == currentUserEmail)
                      .map((tip) => TipWidget(
                    tip: tip['description'],
                    tipId: tip.id, // Pass the tip ID
                    tipController: _tipController,
                  )));
                  combinedData.addAll(tasks
                      .where((task) =>
                  task.containsKey('userEmail') &&
                      task['userEmail'] == currentUserEmail &&
                      (task['repeat'] == 'Daily' ||
                          task['date'] ==
                              DateFormat.yMd().format(_selectedDate)))
                      .map((task) {
                    int index = tasks.indexWhere((element) => element == task);
                    return GestureDetector(
                      onTap: () async {
                        QuerySnapshot<Object?> querySnapshot =
                        await TaskController().tasksCollection.get();
                        List<DocumentSnapshot<Object?>> tasks = querySnapshot.docs;
                        String taskId = tasks[index].id; // Use the correct index
                        setState(() {
                          _showBottomSheet(context, taskId);
                          print("DMM");
                        });
                      },
                      child: AnimationConfiguration.staggeredList(
                        position: index, // Use the correct index
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: TaskWidget(
                                    title: task['title'],
                                    note: task['note'],
                                    startTime: task['startTime'],
                                    endTime: task['endTime'],
                                    selectedColor: task['color'],
                                    isCompleted: task['isComplete'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: combinedData.length,
                    itemBuilder: (context, index) {
                      return combinedData[index];
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }


  _showTasks() {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _taskController.taskList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                if (task['userEmail'] == userEmailID.currentUser?.email) {
                  if (task['repeat'] == 'Daily') {
                    // Split the time string by spaces
                    List<String> parts =
                        task['startTime'].toString().split(' ');
                    // Parse the time part (HH:mm)
                    List<String> timeParts = parts.first.split(':');
                    int hour = int.parse(timeParts[0]);
                    int minute = int.parse(timeParts[1]);
                    // Adjust hour for PM time
                    if (parts.last.toLowerCase() == 'pm') {
                      hour = (hour + 12) % 24;
                    }
                    // Create a DateTime object
                    DateTime date = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, hour, minute);
                    // Format the date
                    var myTime = DateFormat("HH:mm").format(date);
                    notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      task['title'],
                      "${task['note']} in ${task['startTime']}",
                    );

                    return GestureDetector(
                      onTap: () async {
                        QuerySnapshot<Object?> querySnapshot =
                            await TaskController().tasksCollection.get();
                        List<DocumentSnapshot<Object?>> tasks =
                            querySnapshot.docs;
                        String taskId = tasks[index].id;
                        setState(() {
                          _showBottomSheet(context, taskId);
                          print("DMM");
                        });
                      },
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: TaskWidget(
                                    title: task['title'],
                                    note: task['note'],
                                    startTime: task['startTime'],
                                    endTime: task['endTime'],
                                    selectedColor: task['color'],
                                    isCompleted: task['isComplete'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (task['date'] == DateFormat.yMd().format(_selectedDate)) {
                    return GestureDetector(
                      onTap: () async {
                        QuerySnapshot<Object?> querySnapshot =
                            await TaskController().tasksCollection.get();
                        List<DocumentSnapshot<Object?>> tasks =
                            querySnapshot.docs;
                        String taskId = tasks[index].id;
                        setState(() {
                          _showBottomSheet(context, taskId);
                          print("DMM");
                        });
                      },
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: TaskWidget(
                                    title: task['title'],
                                    note: task['note'],
                                    startTime: task['startTime'],
                                    endTime: task['endTime'],
                                    selectedColor: task['color'],
                                    isCompleted: task['isComplete'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            );
          }
        },
      ),
    );
  }

  // _showTips() {
  //   return Expanded(
  //     child: StreamBuilder<QuerySnapshot>(
  //       stream: FirebaseFirestore.instance.collection('Tips').snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else {
  //           final tips = snapshot.data!.docs;
  //           return ListView.builder(
  //             itemCount: tips.length,
  //             itemBuilder: (context, index) {
  //               final tip = tips[index];
  //               return TipWidget(tip: tip['description']);
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, String taskId) {
    Get.bottomSheet(
      FutureBuilder<Map<String, dynamic>?>(
        future: _taskController.getTaskById(taskId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic>? task = snapshot.data;
            if (task != null) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4),
                    height: task['isComplete'] == 1
                        ? MediaQuery.of(context).size.height * 0.28
                        : MediaQuery.of(context).size.height * 0.32,
                    color: Get.isDarkMode ? darkGreyClr : Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 6,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.isDarkMode
                                ? Colors.grey[600]
                                : Colors.grey[300],
                          ),
                        ),
                        Spacer(),
                        task['isComplete'] == 1
                            ? Container()
                            : _bottomSheetButton(
                                label: 'Task Completed',
                                onTap: () async {
                                  int isCompleted = 1;
                                  await _taskController.updateTaskCompletion(
                                      taskId, isCompleted);
                                  Get.back();
                                  setState(() {});
                                },
                                clr: primaryClr,
                                context: context,
                              ),
                        SizedBox(height: 10),
                        _bottomSheetButton(
                          label: 'Delete Task',
                          onTap: () async {
                            Get.back();
                            await _taskController.delete(taskId);
                            setState(() {});
                          },
                          clr: Colors.red[300]!,
                          context: context,
                        ),
                        SizedBox(height: 10),
                        _bottomSheetButton(
                          label: 'Close',
                          onTap: () {
                            Get.back();
                          },
                          clr: Colors.red[300]!,
                          isClose: true,
                          context: context,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container(); // Return an empty container if task details are not available
            }
          }
        },
      ),
      isScrollControlled: true,
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Today',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MyButton(
            label: "Add Task",
            onTap: () async {
              await Get.to(AddTaskPage());
              await _taskController.taskList();
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      // backgroundColor: Get.isDarkMode? Colors.blueGrey[900]:Color.fromRGBO(227, 249, 251, 1),
      leading: GestureDetector(
        onTap: () {
          print('Theme Change');
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme changed",
              body: Get.isDarkMode ? "Activaed Light" : "Activated Dark");
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
