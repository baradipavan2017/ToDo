import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_1/model/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;
  //constructor of databasehelper
  DatabaseHelper._instance();

  //headers for table
  static final _databaseName = 'todo_list.db';
  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  //CREATING DATABASE IF NULL

  Future<Database> get db async {
    //RETURNS db IF DATABSE EXISTS
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  //INITILIZING DB TABLE
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + _databaseName;
    final todoListdb =
        await openDatabase(path, version: 1, onCreate: _createdb);
    return todoListdb;
  }

  Future _createdb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDate TEXT,$colPriority TEXT,$colStatus INTEGER)');
  }

  //GETTING ALL DATA IN MAP
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    final Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }

  //CONVERTING MAP DATA TO LIST
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    return taskList;
  }

  //INSERTING TASKS IN TABLE
  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  //UPDATINGN TASKS IN TABLE
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

  //DELETING THE TASKS
  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      tasksTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
