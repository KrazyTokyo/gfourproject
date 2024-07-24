import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/pages/pages_barrel.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  @override
  Widget build(BuildContext context) {
    final songClass = SongClass();
    final provider = FavoriteProvider.of(context);

    final limitedSongList = songClass.songList.take(9).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridView.count(
                childAspectRatio: 250 / 100,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.fromLTRB(10.0, 13, 10, 10),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text(
                        'Liked Songs',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/fav'),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.asset(
                              'lib/assets/images/bruno_mars/bm64.jpg')),
                      title: const Text(
                        'Bruno Mars Mix',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/bm'),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                          'lib/assets/images/bini/bini64.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text(
                        'BINI Mix',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/bini'),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                            'lib/assets/images/justin_bieber/jb64.jpg'),
                      ),
                      title: const Text(
                        'Justin Bieber Mix',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/jb'),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child:
                              Image.asset('lib/assets/images/jmh/jmh64.jpg')),
                      title: const Text(
                        'John Michael Howell Mix',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/jmh'),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 32, 32, 32),
                    child: ListTile(
                      leading: const Icon(
                        Icons.library_music,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Daily Mix',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/daily'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Recommended for today',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 230.0,
                color: const Color.fromARGB(255, 10, 10, 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: limitedSongList.length,
                  itemBuilder: (context, index) {
                    final song = limitedSongList[index];
                    final songTitle = song.song;

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.asset(
                              song.imagePath,
                              repeat: ImageRepeat.noRepeat,
                              height: 170.0,
                              width: 170.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 10, 10, 10),
                              width: 170.0,
                              height: 60.0,
                              child: ListTile(
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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                title: Text(
                                  songTitle,
                                  style: const TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  song.artist,
                                  style: const TextStyle(
                                      fontSize: 9.0, color: Colors.white),
                                ),
                                trailing: IconButton(
                                  iconSize: 20.0,
                                  onPressed: () {
                                    provider.toggleFavorite(songTitle);
                                  },
                                  icon: provider.isExist(songTitle)
                                      ? const Icon(Icons.favorite,
                                          color:
                                              Color.fromARGB(255, 1, 223, 252))
                                      : const Icon(Icons.favorite_border),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Your Top Artists',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 230.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bini', arguments: true);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/bini/BINI.jpg',
                              repeat: ImageRepeat.noRepeat,
                              height: 170.0,
                              width: 170.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 10, 10, 10),
                              width: 170.0,
                              height: 60.0,
                              child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  onTap: () {},
                                  title: const Text(
                                    'BINI',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: const Text(
                                    'Artist',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/jmh', arguments: true);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/jmh/jmh.jpg',
                              repeat: ImageRepeat.noRepeat,
                              height: 170.0,
                              width: 170.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 10, 10, 10),
                              width: 170.0,
                              height: 60.0,
                              child: const ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  title: Text(
                                    'John Michael Howell',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Artist',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bm', arguments: true);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/bruno_mars/Bruno_Mars.jpg',
                              repeat: ImageRepeat.noRepeat,
                              height: 170.0,
                              width: 170.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 10, 10, 10),
                              width: 170.0,
                              height: 60.0,
                              child: const ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  title: Text(
                                    'Bruno Mars',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Artist',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/jb', arguments: true);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/justin_bieber/Justin_Bieber.jpg',
                              repeat: ImageRepeat.noRepeat,
                              height: 170.0,
                              width: 170.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 10, 10, 10),
                              width: 170.0,
                              height: 60.0,
                              child: const ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  title: Text(
                                    'Justin Bieber',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Artist',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:gfourproject/data/data_barrel.dart';
// import 'package:gfourproject/pages/pages_barrel.dart';

// class HomeNav extends StatefulWidget {
//   const HomeNav({super.key});

//   @override
//   State<HomeNav> createState() => _HomeNavState();
// }

// class _HomeNavState extends State<HomeNav> {
//   @override
//   Widget build(BuildContext context) {
//     final songClass = SongClass();
//     final provider = FavoriteProvider.of(context);
//     final screenWidth = MediaQuery.of(context).size.width;

//     final limitedSongList = songClass.songList.take(9).toList();

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 10, 10, 10),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Adjust GridView layout
//               GridView.count(
//                 childAspectRatio:
//                     (screenWidth / 2) / 150, // Adjust aspect ratio
//                 shrinkWrap: true,
//                 primary: false,
//                 padding: const EdgeInsets.fromLTRB(10.0, 13, 10, 10),
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//                 crossAxisCount:
//                     (screenWidth / 200).floor(), // Adjust number of columns
//                 children: <Widget>[
//                   buildGridCard(
//                     context,
//                     icon: Icons.library_music,
//                     title: 'Liked Songs',
//                     route: '/fav',
//                   ),
//                   buildGridCard(
//                     context,
//                     imagePath: 'lib/assets/images/bruno_mars/bm64.jpg',
//                     title: 'Bruno Mars Mix',
//                     route: '/bm',
//                   ),
//                   buildGridCard(
//                     context,
//                     imagePath: 'lib/assets/images/bini/bini64.jpg',
//                     title: 'BINI Mix',
//                     route: '/bini',
//                   ),
//                   buildGridCard(
//                     context,
//                     imagePath: 'lib/assets/images/justin_bieber/jb64.jpg',
//                     title: 'Justin Bieber Mix',
//                     route: '/jb',
//                   ),
//                   buildGridCard(
//                     context,
//                     imagePath: 'lib/assets/images/jmh/jmh64.jpg',
//                     title: 'John Michael Howell Mix',
//                     route: '/jmh',
//                   ),
//                   buildGridCard(
//                     context,
//                     icon: Icons.library_music,
//                     title: 'Daily Mix',
//                     route: '/daily',
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 'Recommended for today',
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 5.0),
//               Container(
//                 height: 230.0,
//                 color: const Color.fromARGB(255, 10, 10, 10),
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: limitedSongList.length,
//                   itemBuilder: (context, index) {
//                     final song = limitedSongList[index];
//                     final songTitle = song.song;

//                     return MouseRegion(
//                       cursor: SystemMouseCursors.click,
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               song.imagePath,
//                               repeat: ImageRepeat.noRepeat,
//                               height: 170.0,
//                               width: 170.0,
//                               fit: BoxFit.cover,
//                             ),
//                             Container(
//                               color: const Color.fromARGB(255, 10, 10, 10),
//                               width: 170.0,
//                               height: 60.0,
//                               child: ListTile(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SingleSong(
//                                         song: song,
//                                         provider: provider,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 8.0, vertical: 2.0),
//                                 title: Text(
//                                   songTitle,
//                                   style: const TextStyle(
//                                       fontSize: 13.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                                 subtitle: Text(
//                                   song.artist,
//                                   style: const TextStyle(
//                                       fontSize: 10.0, color: Colors.white),
//                                 ),
//                                 trailing: IconButton(
//                                   iconSize: 20.0,
//                                   onPressed: () {
//                                     provider.toggleFavorite(songTitle);
//                                   },
//                                   icon: provider.isExist(songTitle)
//                                       ? const Icon(Icons.favorite,
//                                           color:
//                                               Color.fromARGB(255, 1, 223, 252))
//                                       : const Icon(Icons.favorite_border),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 'Your Top Artists',
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 5.0),
//               SizedBox(
//                 height: 230.0,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     buildArtistCard(
//                       context,
//                       imagePath: 'lib/assets/images/bini/BINI.jpg',
//                       artistName: 'BINI',
//                       route: '/bini',
//                     ),
//                     buildArtistCard(
//                       context,
//                       imagePath: 'lib/assets/images/jmh/jmh.jpg',
//                       artistName: 'John Michael Howell',
//                       route: '/jmh',
//                     ),
//                     buildArtistCard(
//                       context,
//                       imagePath: 'lib/assets/images/bruno_mars/Bruno_Mars.jpg',
//                       artistName: 'Bruno Mars',
//                       route: '/bm',
//                     ),
//                     buildArtistCard(
//                       context,
//                       imagePath:
//                           'lib/assets/images/justin_bieber/Justin_Bieber.jpg',
//                       artistName: 'Justin Bieber',
//                       route: '/jb',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildGridCard(BuildContext context,
//       {IconData? icon,
//       String? imagePath,
//       required String title,
//       required String route}) {
//     return Card(
//       color: const Color.fromARGB(255, 32, 32, 32),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
//         leading: icon != null
//             ? Icon(icon)
//             : ClipRRect(
//                 borderRadius: BorderRadius.circular(4.0),
//                 child: Image.asset(imagePath!),
//               ),
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.white),
//         ),
//         onTap: () => Navigator.pushNamed(context, route),
//       ),
//     );
//   }

//   Widget buildArtistCard(BuildContext context,
//       {required String imagePath,
//       required String artistName,
//       required String route}) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, route, arguments: true);
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//         child: Column(
//           children: [
//             Image.asset(
//               imagePath,
//               repeat: ImageRepeat.noRepeat,
//               height: 170.0,
//               width: 170.0,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               color: const Color.fromARGB(255, 10, 10, 10),
//               width: 170.0,
//               height: 60.0,
//               child: ListTile(
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//                 title: Text(
//                   artistName,
//                   style: const TextStyle(
//                       fontSize: 13.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 subtitle: const Text(
//                   'Artist',
//                   style: TextStyle(fontSize: 10.0, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
