import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:photo_diary/screens/home/home_screen.dart';
import 'package:photo_diary/services/service_locator.dart';
import 'package:photo_diary/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'work_manager.dart';

void main() {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  print('hhhhhhhhereeeeeee');
  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  startBackgroundUpdate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: darktheme(context),
      home: const HomeScreen(),
    );
  }
}
