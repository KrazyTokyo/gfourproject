import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfourproject/pages/pages_barrel.dart';
import 'package:gfourproject/util/util_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    const HomeNav(),
    const Library(),
  ];
  String email = 'No email provided';
  String additionalString = 'This is your first time logged on';

  @override
  void initState() {
    super.initState();
    _retrieveEmail();
  }

  Future<void> _retrieveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString("userEmail");
    if (savedEmail != null) {
      debugPrint('mainhome if');
      setState(() {
        email = savedEmail;
      });
    } else {
      Get.offAll(const Login());
      debugPrint('mainhome else');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args is Map<String, dynamic>) {
      email = args['email'] ?? email;
      additionalString = args['additionalString'] ?? additionalString;
    } else if (args is String) {
      email = args;
    }

    // Strip domain part for certain email addresses
    if (email.endsWith('@gmail.com') ||
        email.endsWith('@g.batstate-u.edu.ph')) {
      email = email.split('@')[0];
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          toolbarHeight: 50.0,
          backgroundColor: const Color.fromARGB(225, 1, 223, 252),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _signOut,
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          child: ListView(
            children: [
              SizedBox(
                height: 55,
                child: DrawerHeader(
                  child: Text(
                    email,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'testing area',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/fav');
                },
              ),
              const SizedBox(
                height: 5.0,
              )
            ],
          ),
        ),
        body: _screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(118, 0, 0, 0).withOpacity(0.5),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: currentIndex == 0
                    ? Colors.white
                    : Colors.white.withOpacity(0.60),
              ),
              activeIcon: const Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music_outlined,
                color: currentIndex == 1
                    ? Colors.white
                    : Colors.white.withOpacity(0.60),
              ),
              activeIcon: const Icon(
                Icons.library_music,
                color: Colors.white,
              ),
              label: 'Library',
            ),
          ],
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
