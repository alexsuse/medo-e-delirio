import 'package:just_audio/just_audio.dart';

class AudioPlayerSingleton {
  static AudioPlayerSingleton _instance = AudioPlayerSingleton._();
  static AudioPlayerSingleton get instance => _instance;

  final AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerSingleton._() {}
}
