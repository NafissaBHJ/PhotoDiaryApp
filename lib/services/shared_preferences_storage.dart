import 'dart:convert';

import 'package:photo_diary/services/service_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage extends StorageService {
  @override
  Future<dynamic>? getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic list;
    String? l = await prefs.getString("list_notes") ?? "";
    if (l.isNotEmpty) {
      list = json.decode(l);
    } else {
      list = null;
    }

    return list;
  }
  @override
  Future<void> setNote(String note) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("list_notes", note);
  }
  
}
