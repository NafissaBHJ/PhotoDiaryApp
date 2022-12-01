import 'package:intl/intl.dart';

class Diary {
  int? id;
  String? title;
  String? caption;
  String imagePath;
  String date;

  Diary(
      {this.id,
      required this.imagePath,
      this.title,
      this.caption,
      required this.date});

  factory Diary.fromMap(dynamic map) {
    return Diary(
        id: map['id'],
        title: map['title'],
        caption: map['text'],
        imagePath: map['path'],
        date: map['date']);
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'title': title,
      'text': caption,
      'path': imagePath,
      'date': date
    };
    return map;
  }

  String convertDate() {
    DateTime time = DateFormat("MM/dd/yyyy").parse(date);
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(time);
  }
}
