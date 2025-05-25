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
    "You’re a rockstar. Now go and rock it.",
    "Today is a new opportunity. Make it count.",
    "Believe in yourself and all that you are.",
    "Success is not the key to happiness. Happiness is the key to success.",
    "The only way to do great work is to love what you do.",
    "Your limitation—it's only your imagination",
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

    final greetingText = isMorning
        ? 'Good Morning'
        : isEvening
            ? 'Good Evening'
            : 'Good Afternoon';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isMorning
                ? [Colors.orange.shade100, Colors.pink.shade100]
                : isEvening
                    ? [Colors.blue.shade500, Colors.deepPurple.shade400]
                    : [Colors.green.shade400, Colors.cyan.shade200],
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
                Column(
                  children: [
                    Text(
                      '$greetingText, ',
                      style: const TextStyle(
                        fontSize: 30,
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
                        fontSize: 26,
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
                fontSize: 18,
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
