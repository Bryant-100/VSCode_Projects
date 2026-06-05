import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_module_1/main.dart';

void main() {
  testWidgets('ArtSpaceApp cycles through artworks', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ArtSpaceApp());

    expect(find.text('Digital Art Space'), findsOneWidget);
    expect(find.text('Wheat Field with Cypresses'), findsOneWidget);
    expect(find.text('Vincent van Gogh • 1889'), findsOneWidget);

    await tester.ensureVisible(find.text('Next'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Flowers Smile Faces'), findsOneWidget);
    expect(find.text('Takashi Murakami • 2020'), findsOneWidget);
    expect(find.text('Wheat Field with Cypresses'), findsNothing);

    await tester.ensureVisible(find.text('Next'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Wheat Field with Cypresses'), findsOneWidget);
    expect(find.text('Vincent van Gogh • 1889'), findsOneWidget);

    await tester.ensureVisible(find.text('Next'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    
    expect(find.text("The Artist's Garden at Vetheuil"), findsOneWidget);
    expect(find.text('Claude Monet • 1881'), findsOneWidget);

    await tester.ensureVisible(find.text('Next'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    
    expect(find.text('Yunoo Pass in the Mountains'), findsOneWidget);
    expect(find.text('Utagawa Hiroshige • 1857'), findsOneWidget);

    await tester.ensureVisible(find.text('Previous'));
    await tester.tap(find.text('Previous'));
    await tester.pumpAndSettle();
  });
}
