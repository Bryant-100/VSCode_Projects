import 'package:flutter/material.dart';
import '../data/note_model.dart';
import '../provider/note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? noteToEdit; // If null, we are adding; if not null, we are editing

  // ignore: use_super_parameters
  const AddNoteScreen({Key? key, this.noteToEdit}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      isEditing = true;
      _titleController.text = widget.noteToEdit!.title;
      _descController.text = widget.noteToEdit!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<NoteProvider>(
                  context,
                  listen: false,
                );
                final title = _titleController.text.trim();
                final description = _descController.text.trim();

                if (title.isEmpty || description.isEmpty) {
                  return;
                }

                if (isEditing) {
                  final updatedNote = Note(
                    id: widget.noteToEdit!.id,
                    title: title,
                    description: description,
                    date: widget.noteToEdit!.date,
                  );
                  await provider.updateNote(updatedNote);
                } else {
                  final freshNote = Note(
                    title: title,
                    description: description,
                    date: DateTime.now(),
                  );
                  await provider.addNote(freshNote);
                }

                // ignore: use_build_context_synchronously
                if (mounted) Navigator.pop(context);
              },
              child: Text(isEditing ? 'Update Note' : 'Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
