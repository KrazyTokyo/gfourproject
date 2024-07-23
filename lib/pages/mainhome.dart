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
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _signOut,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 55,
                child: DrawerHeader(
                  child: Text(email),
                ),
              ),
              ListTile(
                title: const Text('testing area'),
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
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.library_music),
              label: 'Library',
            )
          ],
          onDestinationSelected: (int index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          selectedIndex: currentIndex,
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
