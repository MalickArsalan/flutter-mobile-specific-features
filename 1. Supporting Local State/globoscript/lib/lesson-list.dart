import 'package:flutter/material.dart';
import 'dart:convert';

class LessonListWidget extends StatefulWidget {
  @override
  _LessonList createState() => _LessonList();
}

class _LessonList extends State<LessonListWidget> {
  Future<List<dynamic>> lessons;

  Future<List<dynamic>> fetchList() async {
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/lessons.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    lessons = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lessons,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var lessonInfo = snapshot.data;
          return ListView(
            children: <Widget>[
              for (var lesson in lessonInfo)
                ListTile(
                  leading: Text(lesson["code"],
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold)),
                  title: Text(lesson["name"]),
                )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error! Could not load lesson data!",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)));
        } else {
          return Center(
            child: Text(
              "Loading lesson data... ",
              style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
