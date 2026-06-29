import 'package:flutter/material.dart';
import '../data/note_model.dart';
import '../repository/note_repos.dart';

class NoteProvider with ChangeNotifier {
  final NoteRepository _repository;
  List<Note> _notes = [];
  bool _isLoading = false;

  NoteProvider(this._repository);

  List<Note> get notes => _notes;

  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
  _isLoading = true;
  notifyListeners();

  _notes = await _repository.fetchNotes();

  _isLoading = false;
  notifyListeners();
}

  Future<void> addNote(Note note) async {
    await _repository.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _repository.editNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _repository.removeNote(id);
    await loadNotes();
  }
}
