import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _greetingSection(),
                const SizedBox(height: 16),
                _weatherSection(),
                const SizedBox(height: 16),
                _checklistPreview(),
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

  Widget _greetingSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, Bob! ☀️',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          '"You’ve got this. Coffee helps, but so do you."',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _weatherSection() {
    return const Row(
      children: [
        Icon(Icons.cloud, size: 32),
        SizedBox(width: 12),
        Text('72°F – Showers expected'),
      ],
    );
  }

  Widget _checklistPreview() {
    final checklist = ['Keys', 'Wallet', 'Phone'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Checklist',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        Wrap(
          spacing: 8,
          children: checklist
              .map((item) =>
                  Chip(label: Text(item), avatar: const Icon(Icons.check)))
              .toList(),
        ),
      ],
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
