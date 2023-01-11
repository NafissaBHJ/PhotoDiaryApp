import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'page_painter.dart';

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
