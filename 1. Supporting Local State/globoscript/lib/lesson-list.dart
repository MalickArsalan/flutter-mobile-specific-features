import 'package:flutter/material.dart';

import 'script-data.dart' show lessonInfo;

class LessonListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var lesson in lessonInfo) ListTile(
          leading: Text(lesson["code"],
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold)),
          title: Text(lesson["name"]),
        )
      ],
    );
  }
}
