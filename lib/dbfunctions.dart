import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    // Get the default database directory
    final databasesPath = await getDatabasesPath();
    // Join the path with the 'data' folder and 'data.db' file
    final path = join(databasesPath, 'data', 'data.db');

    // Ensure the 'data' directory exists
    final dataDir = Directory(join(databasesPath, 'data'));
    if (!await dataDir.exists()) {
      await dataDir.create(recursive: true);
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "Department" (
      "Date"	TEXT NOT NULL,
      "Department"	TEXT NOT NULL,
      "Project"	TEXT NOT NULL,
      "Type"	TEXT NOT NULL,
      "Folder"	INTEGER,
      "Location"	TEXT,
      "ID"	INTEGER,
      "Description"	TEXT,
      "Link"	TEXT
    );
    ''');
  }
  //function to add data to the database
  Future<void> addData(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('Department', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    _database = await DatabaseHelper()._initDB();
    //print database path
    // print("Database initialized at: ${_database!.path}");
  }
}
