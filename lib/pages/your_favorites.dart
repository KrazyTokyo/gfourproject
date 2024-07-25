import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';
import 'package:gfourproject/pages/player.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);
    final songsTitles = provider.songsTitles;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: const Color.fromARGB(225, 1, 223, 252),
        title: const Text(
          'Liked Songs',
        ),
      ),
      body: ListView.builder(
        itemCount: songsTitles.length,
        itemBuilder: (context, index) {
          final title = songsTitles[index];
          final song = provider.getSongsByTitle(title);

          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 16, 8),
            leading: Image.asset(
              song.imagePath,
              height: 70.0,
              width: 70.0,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleSong(
                    song: song,
                    provider: provider,
                  ),
                ),
              );
            },
            title: Text(
              song.song,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              song.artist,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPlayer(
                            songList: songClass.songList
                                .map((s) => [
                                      s.song,
                                      s.artist,
                                      s.imagePath,
                                      s.audioPath
                                    ])
                                .toList(),
                            songTitle: song.song,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow)),
                IconButton(
                  onPressed: () {
                    provider.toggleFavorite(title);
                  },
                  icon: provider.isExist(title)
                      ? const Icon(Icons.favorite,
                          color: Color.fromARGB(255, 1, 223, 252))
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
