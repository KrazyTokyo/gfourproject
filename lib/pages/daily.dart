import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';

class Daily extends StatelessWidget {
  const Daily({super.key});

  @override
  Widget build(BuildContext context) {
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
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
