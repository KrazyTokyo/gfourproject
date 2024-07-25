import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyPlayer extends StatefulWidget {
  const MyPlayer({
    super.key,
    required this.songList,
    required this.initialIndex,
  });

  final List<List> songList;
  final int initialIndex;

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    currentIndex = widget.initialIndex;
    _loadSong();

    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      _nextTrack();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _loadSong() async {
    String songUrl = widget.songList[currentIndex][3];
    await _audioPlayer.play(AssetSource(songUrl));
    setState(() {
      isPlaying = true;
    });
  }

  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _nextTrack() {
    if (currentIndex < widget.songList.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        currentIndex = 0;
      });
    }
    _loadSong();
  }

  void _previousTrack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    } else {
      setState(() {
        currentIndex = widget.songList.length - 1;
      });
    }
    _loadSong();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = widget.songList[currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: const Color.fromARGB(225, 1, 223, 252),
        // title: const Text(
        //   'Liked Songs',
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 28, 24),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color.fromARGB(255, 1, 223, 252)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(225, 1, 223, 252),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: SizedBox(
                          width: 500, // Set your desired width here
                          height: 500, // Set your desired height here
                          child: Image.asset(
                            currentSong[2],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(currentSong[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(currentSong[1],
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _formatTime(position),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SliderTheme(
                    data: const SliderThemeData(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0),
                        activeTrackColor: Color.fromARGB(150, 5, 236, 143),
                        inactiveTrackColor: Color.fromARGB(100, 0, 0, 0)),
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await _audioPlayer.seek(position);
                        await _audioPlayer.resume();
                      },
                    ),
                  ),
                  Text(
                    _formatTime(duration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_previous,
                    onPressed: _previousTrack,
                  ),
                  MyPlayerButtons(
                    width: 150,
                    icon: isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: _playPause,
                  ),
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_next,
                    onPressed: _nextTrack,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}

class MyPlayerButtons extends StatelessWidget {
  final double width;
  final IconData icon;
  final VoidCallback onPressed;

  const MyPlayerButtons({
    super.key,
    required this.width,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(225, 1, 223, 252),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(icon, color: Colors.black, size: 30),
      ),
    );
  }
}
