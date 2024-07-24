import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        body: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Library',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30.0),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.library_music,
                color: Colors.white,
              ),
              title: const Text(
                'Liked Songs',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pushNamed(context, '/fav'),
            ),
          ],
        ),
      ),
    );
  }
}
