import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;

    // Fake weather for demo purposes
    final weatherEmoji = hour < 10
        ? '🌅'
        : hour < 17
            ? '🌤️'
            : '🌙';

    final temperature = 23; // You could hook this up with real API data
    final condition = hour < 17 ? 'Sunny' : 'Clear';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.white.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // Emoji weather icon with shimmer
            Text(
              weatherEmoji,
              style: const TextStyle(fontSize: 40),
            ).animate().fadeIn(duration: 1000.ms).shimmer(duration: 3.seconds),

            const SizedBox(width: 20),

            // Temperature + condition
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$temperature°',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 900.ms)
                    .slideY(begin: 0.2),
                Text(
                  condition,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 900.ms)
                    .slideY(begin: 0.3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
