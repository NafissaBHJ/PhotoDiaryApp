import 'package:photo_diary/service_locator.dart';
import 'package:photo_diary/services/service_storage.dart';

import '../notifiers/diary_notifier.dart';

class HomeManager {
  final storageService = getIt<StorageService>(instanceName: 'DatabaseStorage');
  final diaryNotifier = DiaryNotifier();

  // todo: init database
  Future<void> init() async {
    await storageService.openAppDatabase();
    await getDiaries();
  }

  Future<void> getDiaries() async {
    await diaryNotifier.getDiaries();
  }
}
