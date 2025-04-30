import 'package:flutter/material.dart';

class EssentialsPage extends StatelessWidget {
  const EssentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Essentials Page!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
