import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';

class Bm extends StatelessWidget {
  const Bm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArtist =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);

    final filteredSongList = songClass.songList
        .where((song) => song.artist == 'Bruno Mars')
        .toList();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        appBar: isArtist
            ? AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                toolbarHeight: 50.0,
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              )
            : AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                toolbarHeight: 50.0,
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                title: const Text(
                  'Bruno Mars Mix',
                  style: TextStyle(color: Colors.white),
                ),
              ),
        body: isArtist
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'lib/assets/images/bruno_mars/Bruno_Mars.jpg',
                              height: 350.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Bruno Mars',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Artist',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredSongList.length,
                      itemBuilder: (context, index) {
                        final song = filteredSongList[index];
                        final songTitle = song.song;

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 0, 16, 8),
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
                          trailing: IconButton(
                            onPressed: () {
                              provider.toggleFavorite(songTitle);
                            },
                            icon: provider.isExist(songTitle)
                                ? const Icon(Icons.favorite,
                                    color: Color.fromARGB(255, 1, 223, 252))
                                : const Icon(Icons.favorite_border),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredSongList.length,
                      itemBuilder: (context, index) {
                        final song = filteredSongList[index];
                        final songTitle = song.song;

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 0, 16, 8),
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
                          trailing: IconButton(
                            onPressed: () {
                              provider.toggleFavorite(songTitle);
                            },
                            icon: provider.isExist(songTitle)
                                ? const Icon(Icons.favorite,
                                    color: Color.fromARGB(255, 1, 223, 252))
                                : const Icon(Icons.favorite_border),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ));
  }
}
