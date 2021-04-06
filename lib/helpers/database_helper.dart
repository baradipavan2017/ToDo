import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_1/model/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  //constructor of databasehelper
  DatabaseHelper._instance();

  //headers for table
  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';

  //CREATING DATABASE IF NULL
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initdb();
    }
    //RETURNS _db IF DATABSE EXISTS
    return _db;
  }

  Future<Database> _initdb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListdb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE $tasksTable ($colId INTEGER PRIMARYKEY AUTOINCREMENT,$colTitle TEXT,$colDate TEXT, $colPriority TEXT,)');
    });
    return todoListdb;
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(
      tasksTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      tasksTable,
      where: '$colDate = ?',
      whereArgs: [id],
    );
    return result;
  }
}
