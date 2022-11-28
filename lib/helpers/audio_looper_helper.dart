import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AudioHelper {
  static const String PLAYER_MUSIC_ID = "Music";
  static const String PLAYER_SOUND_ID = "Sound";
  String filePath;
  final String id;
  File? audioFile = File("");
  late AudioPlayer audioPlayer;
  bool isPaused = false;
  double _currentVolume = 1;

  AudioHelper({required this.filePath, this.id = PLAYER_MUSIC_ID}) {
    audioPlayer = AudioPlayer(playerId: id);
  }

  Future _loadFile() async {
    String audioName = filePath.replaceAll(' ', '').replaceAll('/', '');

    audioFile = File('${(await getTemporaryDirectory()).path}/$audioName');
    await audioFile!.writeAsBytes((await _loadAsset()).buffer.asUint8List());
  }

  Future<ByteData> _loadAsset() async {
    return await rootBundle.load(filePath);
  }

  void play() async {
    if (audioFile == null) {
      await _loadFile();
    }

    final result = await audioPlayer.play(audioFile!.path, isLocal: true);
    audioPlayer.setVolume(_currentVolume);
  }

  void stop() {
    audioPlayer.stop();
  }

  void pause() {
    if (isPaused) {
      audioPlayer.resume();
    } else {
      audioPlayer.pause();
    }
    isPaused = !isPaused;
  }

  void release() async {
    await audioPlayer.release();
  }

  void mute() {
    _currentVolume = 0;
    audioPlayer.setVolume(_currentVolume);
  }

  void unMute() {
    _currentVolume = 1;
    audioPlayer.setVolume(_currentVolume);
  }

  double get currentVolume {
    return _currentVolume;
  }

  void setPlayerEventListener(void listener(PlayerState state)) {
    audioPlayer.onPlayerStateChanged.listen(listener);
  }

  set setFilePath(String filePath) {
    if (this.filePath != filePath) {
      this.filePath = filePath;
      audioFile = null;
    }
  }
}
