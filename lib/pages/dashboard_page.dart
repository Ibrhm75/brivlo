import 'package:brivlo/sections/checklist_section.dart';
import 'package:brivlo/sections/greeting_section.dart';
import 'package:brivlo/sections/weather_section.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brivlo"),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingSection(),
              SizedBox(height: 16),
              WeatherSection(),
              SizedBox(height: 16),
              ChecklistSection(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
