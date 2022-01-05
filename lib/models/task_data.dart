import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'tasks.dart';
import '../database/database.dart';

class TaskData extends ChangeNotifier {
  // TaskData() {
  //   fetchAllTasks();
  //   // myDB.deleteAll();
  // }

  DBProvider myDB = DBProvider.db;
  List<Task> _tasks = [];

  List<Task> _reversedTasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  fetchAllTasks() async {
    _reversedTasks = await myDB.getAllTasks();
    _tasks = _reversedTasks.reversed.toList();
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addNewTask(String newTask) async {
    _tasks.add(Task(name: newTask));
    myDB.addNewTask(Task(name: newTask));
    _reversedTasks = await myDB.getAllTasks();
    _tasks = _reversedTasks.reversed.toList();
    notifyListeners();
  }

  void toggleTaskDone(Task task) async {
    task.toggleDone();
    myDB.toggleCheckBox(task);
    _reversedTasks = await myDB.getAllTasks();
    _tasks = _reversedTasks.reversed.toList();
    notifyListeners();
  }

  void updateTask(String updatedTask, Task task) async {
    //get the index of the current
    int _index = _tasks.indexOf(task);
    //use the index to update the
    _tasks.removeAt(_index);
    _tasks.insert(_index, Task(name: updatedTask));
    myDB.updateTask(task, updatedTask);
    _reversedTasks = await myDB.getAllTasks();
    _tasks = _reversedTasks.reversed.toList();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    _tasks.remove(task);
    myDB.deleteTask(task.id!);
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Task item = _tasks[oldIndex];
    _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, item);
    _reversedTasks = _tasks.reversed.toList();
    myDB.deleteAll();


    for (Task task in _reversedTasks) {
      myDB.addAllTasksAgain(task);
    }
    notifyListeners();
    _reversedTasks = await myDB.getAllTasks();
    _tasks = _reversedTasks.reversed.toList();
    notifyListeners();
  }
}
