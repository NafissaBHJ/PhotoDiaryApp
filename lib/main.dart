import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:photo_diary/screens/home/home_screen.dart';
import 'package:photo_diary/service_locator.dart';
import 'package:photo_diary/utils/custom_theme.dart';
import 'package:flutter/material.dart';

void main() {
  setupGetIt();
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (BuildContext context) => MyApp(),
  // ));
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
