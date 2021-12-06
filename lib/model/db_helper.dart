import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Task{

  final int taskId;
  final String title;
  final String desc;
  final String priority;
  final String finished;


  Task({
    this.taskId,
    this.title,
    this.desc,
    this.priority,
    this.finished,

  });


  Task.fromMap(Map<String, dynamic> res):
      taskId = res['taskId'],
      title = res['title'],
      desc = res['desc'],
      priority = res['priority'],
      finished = res['finished'];




  Map<String, dynamic> toMap() {
    return {
      'taskId' : taskId,
      'title' : title,
      'desc' : desc,
      'priority' : priority,
      'finished' : finished
    };
  }



}

class DatabaseHelper {


  static final _dbName = 'cycle.db';
  static final _dbVersion = 1;
  static final _tableName = "Task";

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cycle.db'),
      onCreate: (database, version) async {
        await database.execute(
          '''
          CREATE TABLE Task (
          taskId INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          desc TEXT,
          priority TEXT,
          finished BOOLEAN NOT NULL)
          ''',
        );
      },
      version: 1,
    );
  }


  Future<void> insertTask(Task task) async {
  final db = await initializeDB();
  await db.insert(_tableName, task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  print("Done inserting data.....");

}

  Future<void> update(Task task) async {
    final db = await initializeDB();
    await db.update(_tableName, task.toMap(), where: 'taskId = ?', whereArgs: [task.taskId]);
    print("Item updated");
  }


  Future<List<Task>> queryAll() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query(_tableName, orderBy: 'taskId DESC');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }


  getTask(int id) async {
    final Database db = await initializeDB();
    print("get task id");
    var res =await  db.query(_tableName, where: "taskId = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null;
  }


Future<void> delete(int id) async {
    final db = await initializeDB();
    await db.delete(_tableName,
    where: "taskId = ?",
    whereArgs: [id]);
    print("Item deleted");
}

}
