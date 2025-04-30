import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Todo Page!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
