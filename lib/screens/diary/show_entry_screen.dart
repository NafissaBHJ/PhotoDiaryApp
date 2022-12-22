import 'dart:io';
import 'dart:ui';

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
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 10.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: FileImage(File(widget.memory.imagePath)),
                  fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.memory.title ?? "",
                style: Theme.of(context).textTheme.headline3),
          ),
          widget.memory.caption!.isNotEmpty
              ? Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      stateManager.getState();
                    },
                    child: ValueListenableBuilder<bool>(
                        valueListenable: stateManager.sizeNotifier,
                        builder: (context, value, child) {
                          return AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: value == true
                                ? MediaQuery.of(context).size.height / 3
                                : 80,
                            decoration: (BoxDecoration(
                                color: Colors.grey[200]!.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)))),
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               const Center(
                                    child: Icon(
                                  Icons.drag_handle_rounded,
                                  size: 32,
                                )),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(widget.memory.caption!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ),
                                ),
                              ],
                            ),
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
