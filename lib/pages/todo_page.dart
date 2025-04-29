import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
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
