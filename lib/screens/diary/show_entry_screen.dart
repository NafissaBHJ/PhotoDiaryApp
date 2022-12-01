import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_diary/screens/diary/new_entry_screen_manager.dart';
import 'package:photo_diary/service_locator.dart';

import '../../models/diary.dart';

class ShowEntryScreen extends StatefulWidget {
  const ShowEntryScreen({super.key, required this.memory});
  final Diary memory;

  @override
  State<ShowEntryScreen> createState() => _ShowEntryState();
}

class _ShowEntryState extends State<ShowEntryScreen> {
  final stateManager = getIt<NewEntryManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: FileImage(File(widget.memory.imagePath)),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.memory.title ?? ""),
          ),
          widget.memory.caption != null
              ? Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: InkWell(
                    onTap: () {
                      stateManager.getState();
                    },
                    child: ValueListenableBuilder<bool>(
                        valueListenable: stateManager.sizeNotifier,
                        builder: (context, value, child) {
                          return AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: value == true
                                ? MediaQuery.of(context).size.height / 2
                                : 50,
                            decoration: (BoxDecoration(
                                color: Colors.grey[100]!.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)))),
                            duration: const Duration(milliseconds: 500),
                            child: Text(widget.memory.caption!,
                                style: Theme.of(context).textTheme.bodyText1),
                          );
                        }),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
