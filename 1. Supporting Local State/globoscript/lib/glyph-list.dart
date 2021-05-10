import 'package:flutter/material.dart';

import 'script-data.dart' show glyphInfo;

class GlyphListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var glyph in glyphInfo) ListTile(
          leading: Text(glyph["glyph"],
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold)),
          title: Text(glyph["info"]),
        )
      ],
    );
  }
}
