import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/tasks.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

   Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "TodoeyDB.db");
      return await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Todo ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "isDone BIT"
            ")");
      });
    } catch (_) {}
  }

  addNewTask(Task newTask) async {
    try {
      final db = await database;
      var res = await db.rawInsert(
          "INSERT Into Todo (name)"
          " VALUES (?)",
          [newTask.name]);
      return res;
    } catch (_) {}
  }

  addAllTasksAgain(Task newTask) async {
    try {
      final db = await database;
      var res = await db.rawInsert(
          "INSERT Into Todo (name, isDone)"
          " VALUES (?, ?)",
          [newTask.name, newTask.isDone == true ? 0 : 1]);
      return res;
    } catch (_) {}
  }

  getAllTasks() async {
    try {
      final db = await database;
      var res = await db.query("Todo");
      List<Task> list =
          res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
      return list;
    } catch (_) {}
  }

  getAllTasksReversed() async {
    try {
      final db = await database;
      var res = await db.rawQuery('SELECT * FROM Todo ORDER BY id DESC');
      List<Task> list =
          res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
      return list;
    } catch (_) {}
  }

  updateTask(Task task, String updatedTask) async {
    try {
      final db = await database;
      var res = await db.rawUpdate(
          'UPDATE Todo SET name = ? WHERE id = ?', [updatedTask, task.id]);
      return res;
    } catch (_) {}
  }

  toggleCheckBox(Task task) async {
    try {
      final db = await database;
      Task toggledTask =
          Task(id: task.id, name: task.name, isDone: !task.isDone!);
      var res = await db.update("Todo", toggledTask.toMap(),
          where: "id = ?", whereArgs: [task.id]);

      return res;
    } catch (_) {}
  }

  deleteTask(int id) async {
    try {
      final db = await database;
      db.delete("Todo", where: "id = ?", whereArgs: [id]);
    } catch (_) {}
  }

  deleteAll() async {
    try {
      final db = await database;
      db.rawDelete('DELETE FROM Todo');
    } catch (_) {}
  }
}
