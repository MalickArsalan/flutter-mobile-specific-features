import 'package:flutter/material.dart';

import 'glyph-list.dart';
import 'lesson-list.dart';
import 'community.dart';
import 'contact.dart';

void main() {
  runApp(GlobomanticsTabHome());
}

class GlobomanticsTabHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.toc)),
                Tab(icon: Icon(Icons.school)),
                Tab(icon: Icon(Icons.connect_without_contact)),
                Tab(icon: Icon(Icons.mail_outline)),
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
            ],
          ),
        ),
      ),
    );
  }
}