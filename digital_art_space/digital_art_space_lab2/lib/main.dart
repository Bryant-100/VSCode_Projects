import 'package:flutter/material.dart';

void main() {
  runApp(const ArtSpaceApp());
}

class ArtSpaceApp extends StatefulWidget {
  const ArtSpaceApp({super.key});

  @override
  State<ArtSpaceApp> createState() => _ArtSpaceAppState();
}

class _ArtSpaceAppState extends State<ArtSpaceApp> {
  int _currentIndex = 0;

  final List<Map<String, String>> artworks = [
    {
      'title': 'Wheat Field with Cypresses',
      'artist': 'Vincent van Gogh',
      'year': '1889',
      'image': 'assets/wheat_field_with_cypresses.png', // Ensure this image is added to your assets
    },
    {
      'title': 'Flowers Smile Faces',
      'artist': 'Takashi Murakami',
      'year': '2020',
      'image': 'assets/flowers_smile_faces.jpeg', // Ensure this image is added to your assets
    },
    // Add more artworks as needed
    {
      'title': 'The Artist`s Garden at Vetheuil',
      'artist': 'Claude Monet',
      'year': '1881',
      'image': 'assets/the_artists_garden_at_vetheuil.png', // Ensure this image is added to assets
    },

    {
      'title': 'Yunoo Pass in the Mountains',
      'artist': 'Utagawa Hiroshige',
      'year': '1857',
      'image': 'assets/utagawa_hiroshige.png', // Ensure this image is added to assets
    }
  ];

  void _nextArtwork() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % artworks.length;
    });
  }

  void _previousArtwork() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + artworks.length) % artworks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final artwork = artworks[_currentIndex];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Art Space'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Artwork Wall
              Expanded(
                flex: 6,
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      artwork['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Artwork Descriptor
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          artwork['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${artwork['artist']} (${artwork['year']})',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Display Controller
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _previousArtwork,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _nextArtwork,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}