import 'package:flutter/material.dart';

class Affirmation {
  final String message;
  final String imageNetwork;

  const Affirmation({required this.message, required this.imageNetwork});
}

final List<Affirmation> affirmations = [
  const Affirmation(
    message: 'I am constantly growing and evolving into a better version of myself.',
    imageNetwork: 'https://media.istockphoto.com/id/1303780600/photo/mothar-mountain-rock-pools.jpg',
  ),
  const Affirmation(
    message: 'Consistency is my strength. I show up for my goals even when the initial excitement fades.',
    imageNetwork: 'https://images.squarespace-cdn.com/content/v1/5a5986b2cf81e095e172ce87/1581895479166-2OPMV4MIKFTM7OXTUFOG/flyingdawnmarie-red-rock-canyon-state-park-01-banner.jpg',
  ),
  const Affirmation(
    message: 'Only good things await me.',
    imageNetwork: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200&q=80.jpg',
  ),
  const Affirmation(
    message: 'I am worthy of success and happiness.',
    imageNetwork: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1200&q=80',
  ),
  const Affirmation(
    message: 'My potential is limitless and I believe in myself.',
    imageNetwork: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&q=80',
  ),
];

Widget buildAffirmationCard(Affirmation affirmation, BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(16.0),
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageViewer(
                  imageUrl: affirmation.imageNetwork,
                ),
              ),
            );
          },
          child: Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[300],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  affirmation.imageNetwork,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 50, color: Colors.grey[600]),
                          const SizedBox(height: 8),
                          Text('Image failed to load', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            affirmation.message,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Affirmations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Daily Affirmations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        elevation: 2.0,
      ),
      body: ListView.builder(
        itemCount: affirmations.length,
        itemBuilder: (context, index) {
          return buildAffirmationCard(affirmations[index], context);
        },
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        )
      ),
    );
  }
}

