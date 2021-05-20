import 'package:flutter/material.dart';

import 'glyph-list.dart';
import 'lesson-list.dart';
import 'community.dart';
import 'contact.dart';
import 'sample-code.dart';

void main() {
  runApp(GlobomanticsTabHome());
}

class GlobomanticsTabHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.toc)),
                Tab(icon: Icon(Icons.school)),
                Tab(icon: Icon(Icons.connect_without_contact)),
                Tab(icon: Icon(Icons.mail_outline)),
                Tab(icon: Icon(Icons.work_outline)),
              ],
            ),
            title: Text('Globoscript'),
          ),
          body: TabBarView(
            children: [
              GlyphListWidget(),
              LessonListWidget(),
              CommunityWidget(),
              ContactWidget(),
              SampleCodeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
