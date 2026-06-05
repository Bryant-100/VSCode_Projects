import 'package:flutter/material.dart';

void main() {
  runApp(const ArtSpaceApp());
}

class Artwork {
  const Artwork({
    required this.title,
    required this.artist,
    required this.year,
    required this.imagePath,
    required this.accentColor,
    required this.description,
  });

  final String title;
  final String artist;
  final String year;
  final String imagePath;
  final Color accentColor;
  final String description;
}

const List<Artwork> _artworks = [
  Artwork(
    title: 'Wheat Field with Cypresses',
    artist: 'Vincent van Gogh',
    year: '1889',
    imagePath: 'assets/wheat_field_with_cypresses.png',
    accentColor: Color(0xFF2F6B59),
    description:
        'A wind-swept landscape with rolling wheat, dark cypress trees, and a bright summer sky.',
  ),
  Artwork(
    title: 'Flowers Smile Faces',
    artist: 'Takashi Murakami',
    year: '2020',
    imagePath: 'assets/flowers_smile_faces.jpeg',
    accentColor: Color(0xFFE65F2B),
    description:
        'A playful burst of smiling flowers layered with bright pop color and graphic repetition.',
  ),
];

class ArtSpaceApp extends StatelessWidget {
  const ArtSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD46A1F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F0E3),
        useMaterial3: true,
      ),
      home: const ArtGalleryScreen(),
    );
  }
}

class ArtGalleryScreen extends StatefulWidget {
  const ArtGalleryScreen({super.key});

  @override
  State<ArtGalleryScreen> createState() => _ArtGalleryScreenState();
}

class _ArtGalleryScreenState extends State<ArtGalleryScreen> {
  int _currentIndex = 0;

  void _showPreviousArtwork() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _artworks.length) % _artworks.length;
    });
  }

  void _showNextArtwork() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _artworks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final artwork = _artworks[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Digital Art Space',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: Color(0xFF2B2118),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F1E4), Color(0xFFE8D7BE)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -30,
              child: _BackgroundCircle(
                size: 180,
                color: artwork.accentColor.withValues(alpha: 0.12),
              ),
            ),
            Positioned(
              bottom: 70,
              left: -40,
              child: _BackgroundCircle(
                size: 140,
                color: const Color(0xFF6B4E2E).withValues(alpha: 0.08),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: artwork.accentColor.withValues(
                                  alpha: 0.18,
                                ),
                                blurRadius: 28,
                                offset: const Offset(0, 18),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: Image.asset(
                                artwork.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.82),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: artwork.accentColor.withValues(
                                alpha: 0.25,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: artwork.accentColor.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  '${_currentIndex + 1} / ${_artworks.length}',
                                  style: TextStyle(
                                    color: artwork.accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                artwork.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  height: 1.1,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF241A12),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${artwork.artist} • ${artwork.year}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: artwork.accentColor,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                artwork.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Color(0xFF55443A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _showPreviousArtwork,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Previous'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  foregroundColor: artwork.accentColor,
                                  side: BorderSide(color: artwork.accentColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: _showNextArtwork,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Next'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  backgroundColor: artwork.accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  const _BackgroundCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
