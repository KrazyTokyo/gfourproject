import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final fullEmail = args['email'] as String;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        appBar: AppBar(
          toolbarHeight: 50.0,
          backgroundColor: const Color.fromARGB(225, 1, 223, 252),
          title: const Text(
            'Profile',
          ),
        ),
        body: Column(
          children: [
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 60.0,
                ),
                onPressed: () {},
              ),
            ),
            Text(
              'Email: $fullEmail',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            )
          ],
        ));
  }
}
