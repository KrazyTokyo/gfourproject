import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final songsTitles = provider.songsTitles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
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
            onTap: () {},
            title: Text(song.song),
            subtitle: Text(song.artist),
            trailing: IconButton(
              onPressed: () {
                provider.toggleFavorite(song.song);
              },
              icon: provider.isExist(song.song)
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}