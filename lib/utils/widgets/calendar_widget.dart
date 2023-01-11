import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../models/diary.dart';
import '../../screens/home/home_screen_manager.dart';
import '../../services/service_locator.dart';
import 'calendar_cell_widget.dart';
import 'day_number_widget.dart';
import 'header_widget.dart';

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
          return SizedBox(
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
                      date: date,
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
                    date: date,
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