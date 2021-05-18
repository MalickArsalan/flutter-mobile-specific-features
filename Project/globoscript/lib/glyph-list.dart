import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:convert';
import 'dart:developer';

class GlyphListWidget extends StatefulWidget {
  @override
  State<GlyphListWidget> createState() {
    return _GlyphList();
  }
}

class _GlyphList extends State<GlyphListWidget> {
  Future<List<dynamic>> _glyphs;

  AudioCache _audioCache;

  Future<List<dynamic>> fetchList() async {
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/glyphs.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    _glyphs = fetchList();
    _audioCache = new AudioCache(
        prefix: "assets/audio/glyphs/", fixedPlayer: new AudioPlayer());
  }

  @override
  void dispose() {
    _audioCache.fixedPlayer.stop();
    _audioCache.fixedPlayer.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _glyphs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var glyphInfo = snapshot.data;
            return ListView(
              children: <Widget>[
                // Should check that the type of glyph
                // is effectively a Map and contains the keys needed
                for (var glyph in glyphInfo)
                  ListTile(
                      leading: Text(glyph["glyph"],
                          style: TextStyle(
                              fontSize: 39.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                      title: Text(glyph["info"],
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueAccent)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            color: Colors.orange,
                            icon: Icon(Icons.play_circle_outline),
                            onPressed: () => _playShortSound(glyph["audio"]),
                          ),
                          IconButton(
                            color: Colors.deepPurple,
                            icon: Icon(Icons.topic_outlined),
                            onPressed: () => _showWebContent(glyph["web"]),
                          ),
                          IconButton(
                            color: Colors.teal,
                            icon: Icon(Icons.videocam_rounded),
                            onPressed: () =>
                                _playStrokeOrderVideo(glyph["video"]),
                          )
                        ],
                      )),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error! Could not load glyph data!",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            );
          } else {
            return Center(
              child: Text("Loading glyph data...",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            );
          }
        });
  }

  void _playShortSound(String asset) {
    _audioCache.fixedPlayer.stop();
    if (_audioCache.fixedPlayer.state != AudioPlayerState.PLAYING) {
      _audioCache.play(asset);
    }
  }

  void _playStrokeOrderVideo(String filename) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return null;
        });
  }

  void _showWebContent(String url) {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Glyph Info'),
                  ),
                  body: WebView(
                    initialUrl: url,
                    navigationDelegate: (request) {
                      if (request.url == url) {
                        // Wikipedia redirects to .m domain for mobile phones,
                        // so had to change address to the .m domain
                        return NavigationDecision.navigate;
                      } else {
                        // The delegate is triggered for all requests, including the initial one
                        return NavigationDecision.prevent;
                      }
                    },
                  ));
            }));
  }
}
