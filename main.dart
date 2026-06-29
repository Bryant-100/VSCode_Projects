import 'package:flutter/material.dart';
import 'package:mvvm_sqlite_repository_getIt/data/db_helper.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'repository/note_repos.dart';
import 'ui/note_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteProvider(
      NoteRepository(DBHelper()),)..loadNotes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteListScreen(),
    );
  }
}