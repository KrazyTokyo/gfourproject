import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';

class SingleSong extends StatefulWidget {
  final Songs song;
  final FavoriteProvider provider;

  const SingleSong({
    super.key,
    required this.song,
    required this.provider,
  });

  @override
  _SingleSongState createState() => _SingleSongState();
}

class _SingleSongState extends State<SingleSong> {
  late FavoriteProvider provider;

  @override
  void initState() {
    super.initState();
    provider = widget.provider;
  }

  @override
  Widget build(BuildContext context) {
    final songTitle = widget.song.song;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 50.0,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.song.imagePath,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      songTitle,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.song.artist,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 35.0,
                  onPressed: () {
                    setState(() {
                      provider.toggleFavorite(songTitle);
                    });
                  },
                  icon: provider.isExist(songTitle)
                      ? const Icon(Icons.favorite,
                          color: Color.fromARGB(255, 1, 223, 252))
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
