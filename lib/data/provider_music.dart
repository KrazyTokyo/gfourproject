import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class MediaPlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  MediaPlayerProvider() {
    _audioPlayer.onDurationChanged.listen((d) {
      _duration = d;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((p) {
      _position = p;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      nextTrack();
    });
  }

  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;

  void play(String url) async {
    await _audioPlayer.play(AssetSource(url));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    await _audioPlayer.resume();
  }

  void nextTrack() {
    // Implement logic to go to the next track
  }

  void previousTrack() {
    // Implement logic to go to the previous track
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
