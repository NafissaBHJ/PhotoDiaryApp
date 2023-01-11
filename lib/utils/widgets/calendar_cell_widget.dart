import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/diary.dart';
import '../../screens/diary/new_entry_screen.dart';
import '../../screens/diary/show_entry_screen.dart';
import '../../screens/home/home_screen_manager.dart';
import '../../services/service_locator.dart';

class CellWidget extends StatelessWidget {
  CellWidget(
      {Key? key,
      required this.day,
      required this.today,
      required this.date,
      this.memory})
      : super(key: key);
  final int day;
  final bool today;
  final DateTime date;
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
                    builder: ((context) => NewEntryScreen(
                          date: date,
                        ))))
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
              (memory!.imagePath.isEmpty)
                  ? Center(
                      child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: ((context) => NewEntryScreen(
                                      date: date,
                                    ))))
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
