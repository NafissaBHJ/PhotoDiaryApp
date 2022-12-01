import 'package:get_it/get_it.dart';
import 'package:photo_diary/screens/home/home_screen_manager.dart';

import 'screens/diary/new_entry_screen_manager.dart';
import 'services/database_storage.dart';
import 'services/service_storage.dart';
import 'services/shared_preferences_storage.dart';

final getIt = GetIt.instance;

void setupGetIt() async {
  getIt.registerLazySingleton<StorageService>(() => SharedPreferenceStorage(),
      instanceName: "SharedPreferencesStorage");
  getIt.registerLazySingleton<StorageService>(() => DatabaseStorage(),
      instanceName: "DatabaseStorage");

  getIt.registerLazySingleton<NewEntryManager>(() => NewEntryManager());
  getIt.registerLazySingleton<HomeManager>(() => HomeManager());
}
