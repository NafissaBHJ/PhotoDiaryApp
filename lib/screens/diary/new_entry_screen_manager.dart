import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_diary/screens/notifiers/diary_notifier.dart';
import 'package:photo_diary/services/service_storage.dart';
import '../../models/size.dart';
import '../../services/service_locator.dart';

class NewEntryManager {
  final imageNotifier = ValueNotifier<File?>(null);
  final diaryNotifier = DiaryNotifier();
  final sizeNotifier = ValueNotifier<bool>(false);
  var storage = getIt<StorageService>(instanceName: 'DatabaseStorage');

  Future<void> save(String title, String text) async {}

  // Future<String> convertNoteToString(Note note) async {
  //   List<Note> n = await convertStringtoNote() ?? [];
  //   n.add(note);
  //   return jsonEncode(n.map((e) => e.toMap()).toList());
  // }

  // Future<List<Note>?> convertStringtoNote() async {
  //   var nlist = await storage.getNotes();
  //   print(nlist);
  //   return nlist != null
  //       ? List<Note>.from(nlist.map((n) => Note.fromMap(n))).toList()
  //       : null;
  // }
  void getdiary() {}

  Future<void> getImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String imagePath = image.path;
      _updateImage(image.path);
    }
  }

  void _updateImage(String img) {
    imageNotifier.value = File(img);
  }

  void saveEntry(String? title, String? caption, DateTime date) {
    if (imageNotifier.value != null) {
      diaryNotifier.insert(title, caption, imageNotifier.value!.path,
          DateFormat.yMd().format(date));
    }
  }

  Future<void> getState() async {
    sizeNotifier.value = !sizeNotifier.value;
  }
}
