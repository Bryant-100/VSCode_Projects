import 'package:mvvm_sqlite_repository_getIt/data/note_model.dart';

import '../data/db_helper.dart';

class NoteRepository {
  final DBHelper _dbHelper;

  NoteRepository(this._dbHelper);
  Future<List<Note>> fetchNotes() => _dbHelper.getNotes();
  Future<int> addNote(Note note) => _dbHelper.insertNote(note);
  Future<int> editNote(Note note) => _dbHelper.updateNote(note);
  Future<int> removeNote(int id) => _dbHelper.deleteNote(id);
}