import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';

class Bini extends StatelessWidget {
  const Bini({super.key});

  @override
  Widget build(BuildContext context) {
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);

    // Filter songs by the artist "John Michael Howell"
    final filteredSongList =
        songClass.songList.where((song) => song.artist == 'BINI').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BINI Mix'),
      ),
      body: ListView.builder(
        itemCount: filteredSongList.length,
        itemBuilder: (context, index) {
          final song = filteredSongList[index];
          final songTitle = song.song;

          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 16, 8),
            leading: Image.asset(
              song.imagePath,
              height: 70.0,
              width: 70.0,
            ),
            onTap: () {},
            title: Text(songTitle),
            subtitle: Text(song.artist),
            trailing: IconButton(
              onPressed: () {
                provider.toggleFavorite(songTitle);
              },
              icon: provider.isExist(songTitle)
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
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
