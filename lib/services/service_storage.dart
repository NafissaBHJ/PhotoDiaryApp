import '../models/diary.dart';

abstract class StorageService {
  Future<void> setNote(String note) async {}
  Future<dynamic>? getNotes() async {
    return "";
  }

  Future<void> openAppDatabase() async {}
  Future<int?> insertRow(Diary diary) async {
    return null;
  }
  Future<int?> updateRow(Diary diary) async {}
  Future<List<Diary>?> getRecords() async {}
}
