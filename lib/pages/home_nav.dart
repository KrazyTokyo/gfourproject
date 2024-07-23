import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'additionalString',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Text(
              'Welcome to the app!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text('Actions:'),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _logInAgain();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(110, 50)),
                  child: const Text('Log In Again',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      )),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _signUpAnother();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(110, 50)),
                  child: const Text(
                    'Sign Up Another',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _signOut();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(110, 50)),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                )
              ],
            )
          ],
        )),
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
