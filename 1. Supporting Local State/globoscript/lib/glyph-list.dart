import 'package:flutter/material.dart';
import 'dart:convert';

class GlyphListWidget extends StatefulWidget {
  @override
  _GlyphList createState() => _GlyphList();
}

class _GlyphList extends State<GlyphListWidget> {
  Future<List<dynamic>> glyphs;

  Future<List<dynamic>> fetchList() async {
    await Future.delayed(Duration(seconds: 5));
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/glyphs.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    glyphs = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: glyphs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var glyphInfo = snapshot.data;
          return ListView(
            children: <Widget>[
              for (var glyph in glyphInfo)
                ListTile(
                  leading: Text(glyph["glyph"],
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold)),
                  title: Text(glyph["info"]),
                )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error! Could not load glyph data!",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)));
        } else {
          return Center(
            child: Text(
              "Loading glyph data... ",
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
