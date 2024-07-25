import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';
import 'package:gfourproject/pages/player.dart';

class Daily extends StatelessWidget {
  const Daily({super.key});

  @override
  Widget build(BuildContext context) {
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: const Color.fromARGB(225, 1, 223, 252),
        title: const Text(
          'All Songs',
        ),
      ),
      body: ListView.builder(
        itemCount: songClass.songList.length,
        itemBuilder: (context, index) {
          final song = songClass.songList[index];
          final songTitle = song.song;

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
              songTitle,
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
                            songTitle: songTitle,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow)),
                IconButton(
                  onPressed: () {
                    provider.toggleFavorite(songTitle);
                  },
                  icon: provider.isExist(songTitle)
                      ? const Icon(Icons.favorite,
                          color: Color.fromARGB(255, 1, 223, 252))
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => const Favorites(),
          );
          Navigator.push(context, route);
        },
        label: const Text('Favorites'),
      ),
    );
  }
}
