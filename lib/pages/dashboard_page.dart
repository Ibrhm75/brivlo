import 'package:brivlo/components/fade_appbar_layout.dart';
import 'package:brivlo/sections/checklist_section.dart';
import 'package:brivlo/sections/greeting_section.dart';
import 'package:brivlo/sections/weather_section.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAppBarLayout(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GreetingSection(),
                const SizedBox(height: 16),
                const WeatherSection(),
                const SizedBox(height: 16),
                const ChecklistSection(),
                const SizedBox(height: 16),
                _tasksPreview(),
                const SizedBox(height: 16),
                _remindersPreview(),
                const SizedBox(height: 16),
                _dailyFocus(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tasksPreview() {
    final tasks = ['Finish mockups', 'Reply to emails', 'Team sync @ 3pm'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today’s Tasks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ...tasks.map((task) => CheckboxListTile(
              value: false,
              onChanged: (val) {},
              title: Text(task),
            )),
      ],
    );
  }

  Widget _remindersPreview() {
    final reminders = [
      {'time': '9:00 AM', 'label': 'Meeting'},
      {'time': '1:00 PM', 'label': 'Lunch with Sarah'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reminders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ...reminders.map((reminder) => ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(reminder['label']!),
              subtitle: Text(reminder['time']!),
            )),
      ],
    );
  }

  Widget _dailyFocus() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Focus',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Text('Focus: Finish UX mockups'),
      ],
    );
  }
}
