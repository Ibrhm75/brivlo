import 'package:flutter/material.dart';

class FadeAppBarLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const FadeAppBarLayout({
    super.key,
    required this.child,
    this.title = "Brivlo",
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final background = Theme.of(context).colorScheme.background;

    return Scaffold(
      body: Column(
        children: [
          // 👑 Custom AppBar with gradient fade
          Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [primary, background],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),

          // 👇 Your page content
          Expanded(child: child),
        ],
      ),
    );
  }
}
