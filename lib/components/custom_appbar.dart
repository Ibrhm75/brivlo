import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';

class BrivloAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrivloAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background with wave animation
        const Positioned.fill(child: _AnimatedBackground()),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'Logo',
                  child: Image.asset(
                    'assets/images/BrivloLogo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),

                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Brivlo',
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  pause: const Duration(milliseconds: 3000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  repeatForever: true,
                ),

                // const Text(
                //   'Brivlo',
                //   style: TextStyle(
                //     fontSize: 28,
                //     fontWeight: FontWeight.w800,
                //     letterSpacing: 1.2,
                //     color: Colors.white,
                //     fontFamily: 'Poppins',
                //   ),
                // ),
                const Spacer(),
                IconButton(
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _WavePainter(_controller.value),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;

  _WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 196, 183, 9),
          Color.fromARGB(255, 201, 110, 7)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    const waveHeight = 20.0;
    final waveLength = size.width;

    path.moveTo(0, size.height * 0.75);

    for (double i = 0; i <= waveLength; i++) {
      double y = sin((i / waveLength * 2 * pi) + (animationValue * 2 * pi)) *
              waveHeight +
          size.height * 0.75;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color.fromARGB(255, 30, 153, 14).withOpacity(0.5));
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) => true;
}
