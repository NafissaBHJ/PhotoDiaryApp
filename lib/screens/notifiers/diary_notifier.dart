import 'package:flutter/material.dart';
import 'package:photo_diary/services/service_locator.dart';
import 'package:photo_diary/services/service_storage.dart';

import '../../models/diary.dart';

class DiaryNotifier extends ValueNotifier<List<Diary>> {
  DiaryNotifier() : super([]);
  final storageservice = getIt<StorageService>(instanceName: 'DatabaseStorage');

  Future<void> insert(
      String? title, String? caption, String path, String date) async {
    Diary d =
        Diary(imagePath: path, title: title, caption: caption, date: date);
    await storageservice.insertRow(d);
  }

  Future<void> getDiaries() async {
    value = await storageservice.getRecords() ?? [];
    notifyListeners();
  }
}
