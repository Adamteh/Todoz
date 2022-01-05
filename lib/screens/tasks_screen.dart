import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'add_task_screen.dart';
import '../widgets/tasks_list.dart';
import '../models/task_data.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  String taskNumber(int taskCount) {
    String outputText;
    if (taskCount == 0) {
      outputText = 'No Task';
    } else if (taskCount == 1) {
      outputText = '1 Task';
    } else {
      outputText = '$taskCount Tasks';
    }

    return outputText;
  }

  @override
  Widget build(BuildContext context) {
    var taskData = Provider.of<TaskData>(context);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  child:
                      Icon(Icons.list, size: 30, color: Colors.lightBlueAccent),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Todoz',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                Text(taskNumber(taskData.taskCount),
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const TaskList(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => AddTaskScreen(
              text: 'Add Task',
              buttonText: 'Add',
              onPressed: () => taskData.addNewTask(newTaskTitle!),
            ),
          ).then((value) => textEditingController.text = '');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
        tooltip: 'Add Task',
      ),
    );
  }
}
