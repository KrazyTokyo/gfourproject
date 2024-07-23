import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.library_music),
            title: const Text('Liked Songs'),
            onTap: () => Navigator.pushNamed(context, '/fav'),
          ),
        ],
      ),
    );
  }
}
