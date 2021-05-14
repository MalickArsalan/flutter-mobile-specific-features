import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class LessonListWidget extends StatefulWidget {
  @override
  State<LessonListWidget> createState() {
    return _LessonList();
  }
}

class _LessonList extends State<LessonListWidget> {
  Future<List<dynamic>> _lessons;

  AudioPlayer _lessonPlayer;
  AudioCache _audioCache;

  dynamic _lessonPlaying;
  double _currentPlayingPosition = 0;
  double _currentPlayingDuration = 0;

  Future<List<dynamic>> fetchList() async {
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/lessons.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    _lessonPlayer = new AudioPlayer();
    _audioCache = new AudioCache(
        prefix: "assets/audio/lessons/", fixedPlayer: _lessonPlayer);

    _lessonPlayer.onPlayerError.listen((msg) {
      setState(() {
        _currentPlayingDuration = 0.0;
        _currentPlayingPosition = 0.0;
        _lessonPlaying = null;
      });
    });

    _lessonPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _currentPlayingDuration = d.inSeconds.toDouble();
        _currentPlayingPosition = 0.0;
      });
    });

    _lessonPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _currentPlayingPosition = p.inSeconds.toDouble());
    });

    _lessonPlayer.onPlayerCompletion.listen((_) {
      setState(() {
        _lessonPlaying = null;
      });
    });

    _lessons = fetchList();
  }

  @override
  void dispose() {
    _lessonPlayer.stop();
    _lessonPlayer.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      if (_lessonPlayer.state == AudioPlayerState.PLAYING)
        _lessonPlayer.pause();
      else
        _lessonPlayer.resume();
    });
  }

  void _playLesson(dynamic lesson) {
    _lessonPlayer.stop();
    _audioCache.play(lesson["audio"]);
    setState(() => _lessonPlaying = lesson);
  }

  void _stopPlayingLesson() {
    _lessonPlayer.stop();
    setState(() => _lessonPlaying = null);
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _lessons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var lessonInfo = snapshot.data;
            var listView = ListView(
              children: <Widget>[
                // Should check that the type of glyph
                // is effectively a Map and contains the keys needed
                for (var lesson in lessonInfo)
                  ListTile(
                    leading: Text(lesson["code"],
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey)),
                    title: Text(lesson["name"],
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueAccent)),
                    trailing: lesson["audio"] != null
                        ? IconButton(
                            color: Colors.orange,
                            icon: Icon(_lessonPlaying == lesson
                                ? Icons.stop_circle_outlined
                                : Icons.play_circle_outline),
                            onPressed: () => _lessonPlaying == lesson
                                ? _stopPlayingLesson()
                                : _playLesson(lesson))
                        : null,
                  ),
              ],
            );
            if (_lessonPlaying == null) {
              return listView;
            } else {
              return Column(
                children: <Widget>[
                  Expanded(child: listView),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    color: Colors.blueGrey,
                    height: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                              _lessonPlayer.state == AudioPlayerState.PLAYING
                                  ? Icons.pause_sharp
                                  : Icons.play_arrow_outlined),
                          onPressed: () => _togglePause(),
                        ),
                        Expanded(
                            child: Slider(
                          value: _currentPlayingPosition,
                          min: 0.0,
                          max: _currentPlayingDuration,
                          onChanged: (double value) {
                            _lessonPlayer
                                .seek(Duration(seconds: value.toInt()));
                          },
                        )),
                        IconButton(
                          icon: Icon(Icons.close_sharp),
                          onPressed: () => _stopPlayingLesson(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error! Could not load lesson data!",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            );
          } else {
            return Center(
              child: Text("Loading lesson data...",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            );
          }
        });
  }
}
