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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfourproject/data/data_barrel.dart';
import 'package:gfourproject/util/util_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // Limit the number of songs to 9
    final limitedSongList = songClass.songList.take(9).toList();

    return Scaffold(
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
                padding: const EdgeInsets.all(5.0),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text('Liked Songs'),
                      onTap: () => Navigator.pushNamed(context, '/fav'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text('Bruno Mars Mix'),
                      onTap: () => Navigator.pushNamed(context, '/bm'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text('BINI Mix'),
                      onTap: () => Navigator.pushNamed(context, '/bini'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text('Justin Bieber Mix'),
                      onTap: () => Navigator.pushNamed(context, '/jb'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text(
                        'John Michael Howell Mix',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/jmh'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.library_music),
                      title: const Text(
                        'Daily Mix',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/daily'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Actions:'),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Recommended for today'),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 200.0, // Adjusted height for better visibility
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: limitedSongList.length,
                  itemBuilder: (context, index) {
                    final song = limitedSongList[index];
                    final songTitle = song.song;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            song.imagePath,
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            title: Text(
                              songTitle,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                provider.toggleFavorite(songTitle);
                              },
                              icon: provider.isExist(songTitle)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logInAgain() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _signUpAnother() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/signup');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
    showToast(message: "Successfully signed out");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
