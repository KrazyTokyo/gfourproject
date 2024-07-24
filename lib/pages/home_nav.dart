// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gfourproject/data/data_barrel.dart';
// import 'package:gfourproject/util/util_barrel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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

//     // Limit the number of songs to 9
//     final limitedSongList = songClass.songList.take(9).toList();
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               GridView.count(
//                 childAspectRatio: 390 / 100,
//                 shrinkWrap: true,
//                 primary: false,
//                 padding: const EdgeInsets.all(5.0),
//                 crossAxisSpacing: 1,
//                 mainAxisSpacing: 1,
//                 crossAxisCount: 2,
//                 children: <Widget>[
//                   Card(
//                     child: ListTile(
//                       leading: const Icon(Icons.library_music),
//                       title: const Text('Liked Songs'),
//                       onTap: () => Navigator.pushNamed(context, '/fav'),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       leading: const Icon(Icons.library_music),
//                       title: const Text('Bruno Mars Mix'),
//                       onTap: () => Navigator.pushNamed(context, '/bm'),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       leading: const Icon(Icons.library_music),
//                       title: const Text('BINI Mix'),
//                       onTap: () => Navigator.pushNamed(context, '/bini'),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       leading: const Icon(Icons.library_music),
//                       title: const Text('Justin Bieber Mix'),
//                       onTap: () => Navigator.pushNamed(context, '/jb'),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       //contentPadding: EdgeInsets.All(5.0),
//                       leading: const Icon(Icons.library_music),
//                       title: const Text(
//                         'John Michael Howell Mix',
//                         style: TextStyle(fontSize: 14.0),
//                       ),
//                       onTap: () => Navigator.pushNamed(context, '/jmh'),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       //contentPadding: EdgeInsets.All(5.0),
//                       leading: const Icon(Icons.library_music),
//                       title: const Text(
//                         'Daily Mix',
//                         style: TextStyle(fontSize: 14.0),
//                       ),
//                       onTap: () => Navigator.pushNamed(context, '/daily'),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               const Text('Actions:'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               const Text('Recommended for today'),
//               const SizedBox(
//                 height: 5.0,
//               ),
//               SizedBox(
//                 height: 500.0,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: limitedSongList.length,
//                     itemBuilder: (context, index) {
//                       final song = limitedSongList[index];
//                       final songTitle = song.song;

//                       return Card(
//                         margin: const EdgeInsets.all(0),
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               song.imagePath,
//                               height: 120.0,
//                               width: 120.0,
//                               fit: BoxFit.cover,
//                             ),
//                             ListTile(
//                               contentPadding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               title: Text(
//                                 songTitle,
//                                 style: const TextStyle(fontSize: 14.0),
//                               ),
//                               subtitle: Text(
//                                 song.artist,
//                                 style: const TextStyle(fontSize: 12.0),
//                               ),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   provider.toggleFavorite(songTitle);
//                                 },
//                                 icon: provider.isExist(songTitle)
//                                     ? const Icon(Icons.favorite,
//                                         color: Colors.red)
//                                     : const Icon(Icons.favorite_border),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _logInAgain() async {
//     FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }

//   void _signUpAnother() async {
//     FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/signup');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }

//   void _signOut() async {
//     FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/');
//     showToast(message: "Successfully signed out");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }
// }

//import 'package:firebase_auth/firebase_auth.dart';

//import 'package:gfourproject/util/util_barrel.dart';
//import 'package:shared_preferences/shared_preferences.dart';
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
                childAspectRatio: 390 / 100,
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
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
                              height:
                                  60.0, // Set a fixed width for the ListTile
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
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  song.artist,
                                  style: const TextStyle(
                                      fontSize: 10.0, color: Colors.white),
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
                              height:
                                  60.0, // Set a fixed width for the ListTile

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
                              height:
                                  60.0, // Set a fixed width for the ListTile
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
                              height:
                                  60.0, // Set a fixed width for the ListTile
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
                              height:
                                  60.0, // Set a fixed width for the ListTile
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
