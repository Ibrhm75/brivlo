import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    // ☀️ Fake weather data (replace with real API later)
    const String temperature = "23°C";
    const String condition = "Sunny";
    const IconData icon = Icons.wb_sunny_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📌 Section Title
          const Text(
            "Today's Weather",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.2, curve: Curves.easeOut),

          const SizedBox(height: 12),

          // Weather Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary.withOpacity(0.7), secondary.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // 🌞 Icon
                Icon(icon, size: 56, color: Colors.yellow.shade200)
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .scaleXY(begin: 0.8, duration: 800.ms),

                const SizedBox(width: 20),

                // 🌡️ Temp & Condition
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2),
                    const SizedBox(height: 4),
                    Text(
                      condition,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.3),
                  ],
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms)
              .moveY(begin: 10, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}
