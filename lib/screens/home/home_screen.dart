import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photo_diary/screens/diary/new_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_diary/screens/diary/show_entry_screen.dart';
import 'package:photo_diary/screens/home/home_screen_manager.dart';
import 'package:photo_diary/service_locator.dart';

import '../../models/diary.dart';
import '../../utils/widgets/page_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stateManager = getIt<HomeManager>();
  @override
  void initState() {
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

class CalendarWidget extends StatelessWidget {
  CalendarWidget({
    Key? key,
  }) : super(key: key);
  final stateManager = getIt<HomeManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Diary>>(
        valueListenable: stateManager.diaryNotifier,
        builder: (context, value, Child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: MonthView(
              headerBuilder: (date) {
                return HeaderWidget(
                  date: date,
                );
              },
              borderSize: 0,
              cellAspectRatio: 0.5,
              cellBuilder: (date, event, isToday, isInMonth) {
                if (value.isNotEmpty) {
                  return CellWidget(
                      day: date.day,
                      today: isToday,
                      memory: value.firstWhere(
                          (element) =>
                              element
                                  .convertDate()
                                  .compareTo(date.toString()) ==
                              0,
                          orElse: (() =>
                              Diary(imagePath: "", date: date.toString()))));
                } else {
                  return CellWidget(
                    day: date.day,
                    today: isToday,
                    memory: Diary(imagePath: "", date: date.toString()),
                  );
                }
              },
              weekDayBuilder: (day) {
                return const DayNumberWidget();
              },
              showBorder: false,
            ),
          );
        });
  }
}

class DayNumberWidget extends StatelessWidget {
  const DayNumberWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

class CellWidget extends StatelessWidget {
  CellWidget({Key? key, required this.day, required this.today, this.memory})
      : super(key: key);
  final int day;
  final bool today;
  final Diary? memory;
  final stateManager = getIt<HomeManager>();

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        hoverColor: Theme.of(context).hoverColor,
        onTap: () {
          if (memory!.id != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => ShowEntryScreen(
                      memory: memory!,
                    ))));
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: ((context) => const NewEntryScreen())))
                .then((value) => stateManager.getDiaries());
          }
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: today ? Theme.of(context).splashColor : null,
            borderRadius: BorderRadius.circular(5),
            image: memory != null
                ? DecorationImage(
                    image: FileImage(File(memory!.imagePath)),
                    fit: BoxFit.cover)
                : null,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              (today && memory!.imagePath.isEmpty)
                  ? Center(
                      child: InkWell(
                      child: const Hero(
                          tag: "today", child: Icon(Icons.add_rounded)),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: ((context) => const NewEntryScreen())))
                            .then((value) => stateManager.getDiaries());
                      },
                    ))
                  : const SizedBox.shrink(),
              Text(
                day.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              DateFormat.yMMMMEEEEd().format(date),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(
            width: 80,
            child: CustomPaint(
                painter: CurvePainter(
                    color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }
}
