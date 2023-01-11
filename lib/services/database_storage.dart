import 'package:flutter/material.dart';
import 'package:photo_diary/models/diary.dart';
import 'package:photo_diary/services/service_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseStorage extends StorageService {
  late Database database;

  // doc comment : opening the database
  @override
  Future<void> openAppDatabase() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'diary_app_release.db');

    database = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE diary (id INTEGER PRIMARY KEY,title TEXT NULL,text TEXT NULL,path TEXT,date TEXT)');
  }

  Future<void> _onUpgrade(Database db, int oldv, int newv) async {
    if (oldv < newv) {
      await db.execute('ALTER TABLE diary ADD COLUMN date TEXT');
    }
  }

  @override
  Future<int?> insertRow(Diary diary) async {
    int id = await database.insert("diary", diary.toMap());
  }

  @override
  Future<int?> updateRow(Diary diary) async {}

  @override
  Future<List<Diary>?> getRecords() async {
    var records = await database.query('diary');
    List<Diary>? diaryList =
        List.of(records.map((e) => Diary.fromMap(e)).toList());
    return diaryList;
  }
}
