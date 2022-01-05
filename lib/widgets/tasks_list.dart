import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'tasks_tile.dart';
import '../models/task_data.dart';
import '../screens/add_task_screen.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        List _tasks = taskData.tasks;
        return ReorderableListView(
          onReorder: taskData.onReorder,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: List.generate(_tasks.length, (index) {
            return TaskTile(
              key: PageStorageKey(index.toString()),
              id: (_tasks[index].id.toString() +
                  _tasks[index].name +
                  _tasks[index].id.toString()),
              taskTitle: _tasks[index].name,
              isChecked: _tasks[index].isDone,
              checkboxCallBack: (bool? checkboxState) {
                taskData.toggleTaskDone(_tasks[index]);
              },
              deleteTaskCallBack: (DismissDirection? dismissDirection) {
                if (dismissDirection == DismissDirection.endToStart) {
                  taskData.deleteTask(_tasks[index]);
                } else if (dismissDirection == DismissDirection.startToEnd) {
                  textEditingController.text = _tasks[index].name;
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => AddTaskScreen(
                      text: 'Edit Task',
                      buttonText: 'Update',
                      onPressed: () =>
                          taskData.updateTask(newTaskTitle!, _tasks[index]),
                    ),
                  ).whenComplete(() => textEditingController.text = '');
                }
              },
            );
          }),
        );
      },
    );
  }
}
