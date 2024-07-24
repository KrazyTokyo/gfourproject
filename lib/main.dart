import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gfourproject/firebase_options.dart';
import 'package:gfourproject/pages/pages_barrel.dart';
import 'package:provider/provider.dart';

import 'data/data_barrel.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Basics',
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/signup': (context) => const SignUp(),
          '/mainhome': (context) => const MainHome(),
          '/bini': (context) => const Bini(),
          '/bm': (context) => const Bm(),
          '/jb': (context) => const Jb(),
          '/jmh': (context) => const Jmh(),
          '/lib': (context) => const Library(),
          '/fav': (context) => const Favorites(),
          '/homenav': (context) => const HomeNav(),
          '/daily': (context) => const Daily(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}
