import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:photo_diary/screens/home/home_screen_manager.dart';
import 'package:photo_diary/services/service_locator.dart';

import '../../utils/widgets/calendar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stateManager = getIt<HomeManager>();

  @override
  void initState() {
    super.initState();
    stateManager.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            height: 40,
            width: 80,
            child:
                Image.asset("assets/images/pdiary.png", fit: BoxFit.contain)),
      ),
      body: CalendarControllerProvider(
          controller: EventController(), child: CalendarWidget()),
    );
  }
}
