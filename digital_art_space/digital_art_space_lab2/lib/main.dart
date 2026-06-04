import 'package:flutter/material.dart';

void main() {
  runApp(const ArtSpaceApp());
}

class ArtSpaceApp extends StatelessWidget {
  const ArtSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Art Space'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              // Artwork Image
              Image.asset(
                'assets/artwork_1.png',
                height: 300,
              ),

              const SizedBox(height: 20),

              // Artwork Information
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text(
                        'Wheat Field with Cypresses',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Vincent Van Gogh'),
                      Text('1889'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Second Artwork
              Image.asset(
                'assets/artwork_2.png',
                height: 220,
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text(
                        'Flowers Smile Faces',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Takashi Murakami'),
                      Text('2020'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}