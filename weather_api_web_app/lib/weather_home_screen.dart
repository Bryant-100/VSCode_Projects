import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_background.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  final TextEditingController cityController = TextEditingController();

  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  Future<void> getWeather() async {
    if (cityController.text.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final data = await weatherService.fetchWeather(cityController.text);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final condition = weatherData != null ? weatherData!['weather'][0]['main'] : 'default';
    final temp = weatherData != null ? weatherData!['main']['temp'].round().toString() : '--';
    final cityName = weatherData != null ? weatherData!['name'] : 'Search a City';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: WeatherTheme.getBackgroundGradient(condition),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: TextField(
                  controller: cityController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter city name...",
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onSubmitted: (_) => getWeather(),
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              Text(
                                cityName,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black26,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                condition,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white70,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Icon(
                                WeatherTheme.getWeatherIcon(condition),
                                size: 120,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 40),
                              Text(
                                "$temp°C",
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
