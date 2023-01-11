import 'dart:io';

import 'package:photo_diary/screens/diary/new_entry_screen_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/service_locator.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key, required this.date});
  final DateTime date;

  @override
  State<NewEntryScreen> createState() => _NewEntryScreen();
}

class _NewEntryScreen extends State<NewEntryScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller1 = TextEditingController();
    var controller2 = TextEditingController();
    var stateManager = getIt<NewEntryManager>();

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: (() {
                  stateManager.saveEntry(
                      controller1.text, controller2.text, widget.date);
                  Navigator.of(context).pop();
                }),
                child: Text('Save'))
          ],
        ),
        body: Hero(
            tag: "today",
            child: Page(
              titleController: controller1,
              captionController: controller2,
            )));
  }
}

class Page extends StatelessWidget {
  Page({Key? key, required titleController, required captionController})
      : _controllerTitle = titleController,
        _controllerCaption = captionController,
        super();

  final TextEditingController _controllerTitle;

  final TextEditingController _controllerCaption;
  var stateManager = getIt<NewEntryManager>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: Platform.isWindows ? EdgeInsets.zero : EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerTitle,
                decoration: const InputDecoration(hintText: "Title ..."),
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyText1,
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )),
      Expanded(
        child: ImageWidget(),
      ),
      Expanded(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: InputWidget(
              controller: _controllerCaption,
            )),
      ),
    ]);
  }
}

class ImageWidget extends StatefulWidget {
  ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final stateManager = getIt<NewEntryManager>();

  @override
  void dispose() {
    super.dispose();
    stateManager.imageNotifier.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).splashColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: ValueListenableBuilder<File?>(
          valueListenable: stateManager.imageNotifier,
          builder: (context, value, child) {
            if (value == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      size: 36,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: (() => stateManager.getImage()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Add today\'s memory',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(alignment: Alignment.topLeft, children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(value, fit: BoxFit.cover)),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => stateManager.getImage(),
                )
              ]);
            }
          }),
    );
  }
}

class InputWidget extends StatelessWidget {
  InputWidget({Key? key, required this.controller}) : super(key: key);
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Enter caption ..."),
        style: Theme.of(context).textTheme.bodyText1,
        cursorColor: Theme.of(context).colorScheme.secondary,
        maxLines: 50,
      ),
    );
  }
}
