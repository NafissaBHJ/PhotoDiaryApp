import 'package:flutter/material.dart';
import 'package:photo_diary/models/diary.dart';
import 'package:photo_diary/services/service_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseStorage extends StorageService {
  late Database database;
  @override
  Future<void> openAppDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'diary_app.db');
    database = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE diary (id INTEGER PRIMARY KEY,title TEXT NULL,text TEXT NULL,path TEXT)');
  }

  Future<void> _onUpgrade(Database db, int oldv, int newv) async {
    await db.execute('ALTER TABLE diary ADD COLUMN date TEXT');
  }

  @override
  Future<int?> insertRow(Diary diary) async {
    int id = await database.insert("diary", diary.toMap());
    print('insert id ---> $id');
  }

  @override
  Future<int?> updateRow(Diary diary) async {}

  @override
  Future<List<Diary>?> getRecords() async {
    var records = await database.query('diary');
    print("here are the records $records");
    List<Diary>? diaryList = records != null
        ? List.of(records.map((e) => Diary.fromMap(e)).toList())
        : [];
    return diaryList;
  }
}
