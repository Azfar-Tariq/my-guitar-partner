import 'package:flutter/material.dart';
import 'package:my_guitar_partner/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userEmail;

  @override
  void initState() {
    super.initState();

    client.auth.onAuthStateChange.listen((event) {
      setState(() {
        userEmail = client.auth.currentUser?.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Guitar Partner'),
        actions: [
          IconButton(
            onPressed: () {
              client.auth.signOut();
              Navigator.pushReplacementNamed(
                context,
                '/signin',
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Hello,',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$userEmail',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
