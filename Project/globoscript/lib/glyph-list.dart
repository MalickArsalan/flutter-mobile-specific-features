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
          return VideoDialogBox(
            file: "assets/video/glyphs/" + filename,
          );
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
        },
      ),
    );
  }
}

class VideoDialogBox extends StatefulWidget {
  final String file;
  VideoDialogBox({Key key, this.file}) : super(key: key);

  @override
  _VideoDialogBoxState createState() => _VideoDialogBoxState();
}

class _VideoDialogBoxState extends State<VideoDialogBox> {
  VideoPlayerController _controller;
  bool _playClicked = false;
  bool _replayClicked = false;
  bool _slowPlay = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.file)
      // cascade operator (not technically an operator, just Dart syntax)
      ..initialize().then((_) {
        // autoplay the video as soon as initialized
        _controller.play();
      });

    _controller.addListener(() {
      log("Cideo Player State = ${_controller.value}");

      if (_replayClicked ||
          (_playClicked &&
              (_controller.value.position == _controller.value.duration))) {
        _controller.seekTo(Duration.zero);
      }
      _playClicked = false;
      _replayClicked = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("Stroke Order"),
        content: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Text("..Loading"),
        actions: [
          IconButton(
            onPressed: () {
              _playClicked = true;
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            onPressed: () {
              _replayClicked = true;
              _controller.play();
            },
            icon: Icon(Icons.replay),
          ),
          IconButton(
            onPressed: () {
              if (_slowPlay) {
                _controller.setPlaybackSpeed(1.0);
              } else {
                _controller.setPlaybackSpeed(.33);
              }
              setState(() {
                _slowPlay = !_slowPlay;
              });
            },
            icon: Icon(Icons.slow_motion_video),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    log("video player disposed");
    super.dispose();
  }
}
