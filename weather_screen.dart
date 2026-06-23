import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  final TextEditingController cityController =
  TextEditingController();

  Map<String, dynamic>? weatherData;

  Future<void> getWeather() async {
    final data =
    await weatherService.fetchWeather(cityController.text);

    setState(() {
      weatherData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "Enter City",
              ),
            ),
            ElevatedButton(
              onPressed: getWeather,
              child: const Text("Get Weather"),
            ),
            if (weatherData != null)
              Column(
                children: [
                  Text(weatherData!['name']),
                  Text(
                    '${weatherData!['main']['temp']} °C',
                  ),
                  Text(
                    weatherData!['weather'][0]['description'],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}