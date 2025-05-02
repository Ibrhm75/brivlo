import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreetingSection extends StatefulWidget {
  const GreetingSection({super.key});

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection> {
  String quote = "";
  String nickname = "";

  final List<String> quotes = [
    "You’ve got this. Coffee helps, but so do you.",
    "Today’s a fresh page. Write something awesome.",
    "Sun’s out. Smile’s out. Let’s do this.",
    "Your checklist is trembling. You’re about to conquer it.",
    "Stay strong. Stay curious. Stay caffeinated.",
  ];

  @override
  void initState() {
    super.initState();
    quote = (quotes..shuffle()).first;
    _loadNickname();
  }

  Future<void> _loadNickname() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nickname = prefs.getString('nickname') ?? 'friend';
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isMorning = hour < 12;
    final isEvening = hour >= 18;

    final greetingEmoji = isMorning
        ? '🌅'
        : isEvening
            ? '🌙'
            : '🌤️';

    final greetingText = isMorning
        ? 'Good Morning'
        : isEvening
            ? 'Good Evening'
            : 'Good Afternoon';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isMorning
                ? [Colors.orange.shade100, Colors.pink.shade100]
                : isEvening
                    ? [Colors.indigo.shade300, Colors.deepPurple.shade100]
                    : [Colors.blue.shade200, Colors.cyan.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  greetingEmoji,
                  style: const TextStyle(fontSize: 40),
                )
                    .animate()
                    .shimmer(duration: 3.seconds)
                    .fadeIn(duration: 1200.ms),
                const SizedBox(width: 12),
                Column(
                  children: [
                    Text(
                      '$greetingText, ',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 1000.ms)
                        .slideY(begin: 0.3, curve: Curves.easeOutCubic),
                    Text(
                      '${nickname.isEmpty ? 'friend' : nickname}!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 1000.ms)
                        .slideY(begin: 0.3, curve: Curves.easeOutCubic),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '“$quote”',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 1200.ms)
                .slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }
}
