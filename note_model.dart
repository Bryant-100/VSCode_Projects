class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime date;

  Note({this.id, required this.title, required this.description, required this.date});

  // Convert a Note object into a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Extract a Note object from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}