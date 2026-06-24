import 'package:flutter/material.dart';

class WeatherTheme {
  // Get a background gradient based on the weather condition
  static LinearGradient getBackgroundGradient(
      String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return LinearGradient(
          colors: [Colors.orangeAccent, Colors.deepOrange],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'clouds':
        return LinearGradient(
          colors: [Colors.blueGrey.shade300, Colors.blueGrey.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return LinearGradient(
          colors: [Colors.indigo.shade400, Colors.indigo.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'snow':
        return LinearGradient(
          colors: [Colors.lightBlue.shade100, Colors.blue.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  // Get a large illustrative icon or image URL based on weather
  static IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.umbrella;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.cloud;
    }
  }
}
Widget build(BuildContext context, String cityName, String condition) {
  // Assuming 'weatherData' is the Map returned from your WeatherService

  return Scaffold(
    body: Container(
      // 1. Dynamic Background Color/Gradient applied here
      decoration: BoxDecoration(
        gradient: WeatherTheme.getBackgroundGradient(condition),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cityName,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),

              // 2. Dynamic Weather Image/Icon applied here
              Icon(
                WeatherTheme.getWeatherIcon(condition),
                size: 100,
                color: Colors.white,
              ),

              const SizedBox(height: 20),
              Text(
                condition,
                style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w300, color: Colors.white),
              ),
              Text(
                condition,
                style: const TextStyle(fontSize: 24, color: Colors.white70, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
