import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_module_1/main.dart';

void main() {
  testWidgets('ArtSpaceApp displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ArtSpaceApp());

    expect(find.text('Digital Art Space'), findsOneWidget);
    expect(find.text('Wheat Field with Cypresses'), findsOneWidget);
    expect(find.text('Vincent van Gogh'), findsOneWidget);
    expect(find.text('1889'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(find.text('Flowers Smile Faces'), findsOneWidget);
    expect(find.text('Takashi Murakami'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);

    // Add more local images and assertions as needed
  });
}
