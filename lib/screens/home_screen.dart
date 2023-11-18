import 'package:flutter/material.dart';
import 'package:my_guitar_partner/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(ModalRoute.of(context)?.settings.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Guitar Partner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Hello ${client.auth.currentUser!.email}',
            style: const TextStyle(fontSize: 18.0),
          ),
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
    );
  }
}
