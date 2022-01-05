import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'screens/tasks_screen.dart';
import 'models/task_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TaskData _taskData = TaskData();

  @override
  void initState() {
    _taskData.fetchAllTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _taskData,
      child: const MaterialApp(
        title: 'Todoz',
        home: TasksScreen(),
      ),
    );
  }
}
