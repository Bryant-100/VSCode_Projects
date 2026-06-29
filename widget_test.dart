import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:mvvm_sqlite_repository_getIt/data/db_helper.dart';
import 'package:mvvm_sqlite_repository_getIt/provider/note_provider.dart';
import 'package:mvvm_sqlite_repository_getIt/repository/note_repos.dart';
import 'package:mvvm_sqlite_repository_getIt/ui/note_list_screen.dart';

void main() {
  testWidgets('user can create four notes and edit one', (
    WidgetTester tester,
  ) async {
    final provider = NoteProvider(NoteRepository(DBHelper()));

    await tester.pumpWidget(
      ChangeNotifierProvider<NoteProvider>.value(
        value: provider,
        child: const MaterialApp(home: NoteListScreen()),
      ),
    );

    expect(find.text('No notes available.'), findsOneWidget);

    for (var i = 1; i <= 4; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'Note $i');
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Description $i',
      );
      await tester.tap(find.text('Save Note'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Note 1'), findsOneWidget);
    expect(find.text('Note 2'), findsOneWidget);
    expect(find.text('Note 3'), findsOneWidget);
    expect(find.text('Note 4'), findsOneWidget);

    expect(find.textContaining('ID: 1'), findsOneWidget);
    expect(find.textContaining('Description: Description 1'), findsOneWidget);
    expect(find.textContaining('Date:'), findsNWidgets(4));

    await tester.tap(find.byIcon(Icons.edit).at(1));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Updated Note 2');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Updated Description 2',
    );
    await tester.tap(find.text('Update Note'));
    await tester.pumpAndSettle();

    expect(find.text('Updated Note 2'), findsOneWidget);
    expect(
      find.textContaining('Description: Updated Description 2'),
      findsOneWidget,
    );
    expect(find.text('Note 2'), findsNothing);
  });
}