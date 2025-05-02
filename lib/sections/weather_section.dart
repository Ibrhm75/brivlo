import 'package:brivlo/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

class WeatherSection extends StatefulWidget {
  const WeatherSection({super.key});

  @override
  State<WeatherSection> createState() => _WeatherSectionState();
}

class _WeatherSectionState extends State<WeatherSection> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  String _city = "New York"; // Fallback if nothing is set

  @override
  void initState() {
    super.initState();
    _loadCityAndFetchWeather();
  }

  Future<void> _loadCityAndFetchWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString('city');

    setState(() {
      _city = savedCity?.isNotEmpty == true ? savedCity! : _city;
    });

    try {
      final weather = await _wf.currentWeatherByCityName(_city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Failed to fetch weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              const Text(
                "Weather in ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, curve: Curves.easeOut),
              Text(
                _weather?.areaName ?? _city,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, curve: Curves.easeOut),
            ],
          ),

          const SizedBox(height: 12),

          // Weather Card or Loading
          _weatherCard(primary, secondary)
              .animate()
              .fadeIn(delay: 300.ms)
              .moveY(begin: 10, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }

  Widget _weatherCard(Color primary, Color secondary) {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
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
          Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
                ),
              ),
            ),
          ),

          const SizedBox(width: 20),

          // 🌡️ Temp & Condition
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_weather?.temperature?.celsius?.toStringAsFixed(0)} °C",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2),
              const SizedBox(height: 4),
              Text(
                _weather?.weatherDescription ?? "Unknown",
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
    );
  }
}


