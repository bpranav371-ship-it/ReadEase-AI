class DatabaseService {
  // Initialize as an empty list to avoid null operator errors
  static List<Map<String, String>> savedNotes = [];

  static void addNote(String text, {String title = "Untitled Note"}) {
    savedNotes.add({
      'title': title,
      'content': text,
      'date': DateTime.now().toString().substring(0, 10),
    });
  }
}