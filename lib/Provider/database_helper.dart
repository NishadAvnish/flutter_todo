import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/models/database%20_model.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance(); // Named Constructor to create a instance of DatabaseHelper class
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "notes.db");

    final _tododatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return _tododatabase;
  }

  Future<void> _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,deadLine TEXT,category TEXT)');
  }

  Future<void> insert(Map<String,dynamic> data) async {
    Database db = await this.database;
    db.insert("notes", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(int id) async {
    Database db = await this.database;
    db.rawDelete("DELETE FROM notes WHERE id=$id");
  }

  Future<void> update(Map<String, dynamic> data) async {
    Database db = await this.database;
    db.rawDelete("UPDATE notes SET id=${data["id"]},title=${data["title"]},description=${data["description"]},deadLine=${data["deadLine"]},category=${data["category"]}");
  }

  Future<void> fetch(String category) async {
    Database db = await this.database;
    db.rawQuery("Select * from notes WHERE category=$category ");
  }
}
