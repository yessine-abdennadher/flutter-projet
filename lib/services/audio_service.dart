import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  Future<void> playBackgroundMusic() async {
    await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    await _backgroundPlayer.play(AssetSource('audio/background.mp3'));
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  void playEffect(String effect) {
    _effectPlayer.stop();
    _effectPlayer.play(AssetSource('audio/1-efek-sound-4-220032.mp3'));
  }
  void playEffectWrong(String effect) {
    _effectPlayer.stop();
    _effectPlayer.play(AssetSource('audio/buzzer-or-wrong-answer-20582.mp3'));
  }

  void dispose() {
    _backgroundPlayer.stop(); // on arrête le son
    _backgroundPlayer.dispose();
    _effectPlayer.dispose();
  }

}
