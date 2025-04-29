import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
