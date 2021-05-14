import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:audioplayers/audioplayers.dart';

class SampleCodeWidget extends StatelessWidget {
  void registerEvents(AudioPlayer player) {
    player.onPlayerError.listen((String msg) {
      log("GloboScript: Player ${player.playerId} -> onPlayerError $msg");
    });

    player.onDurationChanged.listen((Duration d) {
      log("GloboScript: Player ${player.playerId} -> onDurationChanged $d");
    });

    player.onAudioPositionChanged.listen((Duration pos) {
      log("GloboScript: Player ${player.playerId} -> onAudioPositionChanged $pos");
    });

    player.onSeekComplete.listen((void event) {
      log("GloboScript: Player ${player.playerId} -> onSeekComplete");
    });

    player.onPlayerCompletion.listen((void event) {
      log("GloboScript: Player ${player.playerId} -> onPlayerCompletion");
    });

    player.onPlayerStateChanged.listen((AudioPlayerState state) {
      log("GloboScript: Player ${player.playerId} -> onPlayerStateChanged $state");
    });
  }

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.audiotrack),
          title: Text("Tap here for a simple sound",
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent)),
          trailing: null,
          onTap: simpleSound,
        ),
        ListTile(
          leading: Icon(Icons.audiotrack),
          title: Text("Tap here for a longer audio track",
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent)),
          trailing: null,
          onTap: longTrack,
        ),
      ],
    );
  }

  Future<int> simpleSound() async {
    AudioPlayer simplePlayer = new AudioPlayer();
    registerEvents(simplePlayer);
    int result = await simplePlayer.play(
        "https://upload.wikimedia.org/wikipedia/commons/b/bd/Nokia_tune.ogg");
    simplePlayer.setReleaseMode(ReleaseMode.LOOP);
    return result;
  }

  void localFile() async {
    final docsDir = await getApplicationDocumentsDirectory();
    AudioPlayer localPlayer = new AudioPlayer();
    localPlayer.play("${docsDir.path}/audio.mp3", isLocal: true);
  }

  void byteArray() {
    Uint8List byteData /* = <Load audio as a byte array here> */;
    AudioPlayer bytesPlayer = new AudioPlayer();
    bytesPlayer.playBytes(byteData);
  }

  void longTrack() {
    AudioPlayer fullPlayer = new AudioPlayer();
    registerEvents(fullPlayer);
    fullPlayer.play(
        "https://upload.wikimedia.org/wikipedia/commons/d/de/W._A._Mozart_-_Die_Zauberflöte_-_18._Der_Hölle_Rache_kocht_in_meinem_Herzen_%28Ferenc_Fricsay%2C_1953%29.ogg",
        volume: 0.7,
        stayAwake: true,
        respectSilence: true);
  }
}
