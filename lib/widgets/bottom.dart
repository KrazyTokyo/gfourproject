import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:provider/provider.dart';
// Replace with the actual path of your provider

class BottomMediaPlayer extends StatelessWidget {
  const BottomMediaPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaPlayer = Provider.of<MediaPlayerProvider>(context);

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                    mediaPlayer.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (mediaPlayer.isPlaying) {
                    mediaPlayer.pause();
                  } else {
                    mediaPlayer.resume();
                  }
                },
                color: Colors.white,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Song",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatTime(mediaPlayer.position) +
                          " / " +
                          _formatTime(mediaPlayer.duration),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  mediaPlayer.pause();
                },
                color: Colors.white,
              ),
            ],
          ),
          // Slider(
          //   value: mediaPlayer.position.inSeconds.toDouble(),
          //   max: mediaPlayer.duration.inSeconds.toDouble(),
          //   onChanged: (value) {
          //     mediaPlayer.isPlaying.seek(Duration(seconds: value.toInt()));
          //   },
          // ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
