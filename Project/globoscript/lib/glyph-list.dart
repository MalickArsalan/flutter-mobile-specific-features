import 'package:audioplayers/audio_cache.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GlyphListWidget extends StatefulWidget {
  @override
  _GlyphList createState() => _GlyphList();
}

class _GlyphList extends State<GlyphListWidget> {
  Future<List<dynamic>> glyphs;

  AudioCache _audioCache;

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
    _audioCache = new AudioCache(
        prefix: "assets/audio/glyphs/", fixedPlayer: new AudioPlayer());
  }

  @override
  void dispose() {
    _audioCache.fixedPlayer.stop();
    _audioCache.fixedPlayer.dispose();
    super.dispose();
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
                    leading: Text(
                      glyph["glyph"],
                      style: TextStyle(
                          fontSize: 39.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    title: Text(glyph["info"],
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueAccent)),
                    trailing: IconButton(
                      icon: Icon(Icons.play_circle_fill_outlined),
                      onPressed: () => _playShortSound(glyph["audio"]),
                    ))
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

  void _playShortSound(String asset) {
    _audioCache.fixedPlayer.stop();
    if (_audioCache.fixedPlayer.state != AudioPlayerState.PLAYING) {
      _audioCache.play(asset);
    }
  }
}
