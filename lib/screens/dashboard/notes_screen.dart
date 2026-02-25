import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> deleteNote(int index) async {
    final prefs = await SharedPreferences.getInstance();
    notes.removeAt(index);
    await prefs.setStringList('notes', notes);
    setState(() {});
  }

  void openNote(String noteText, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NoteDetailScreen(noteText: noteText, index: index),
      ),
    ).then((_) => loadNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Notes"),
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No saved notes yet"))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                notes[index],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => openNote(notes[index], index),
            ),
          );
        },
      ),
    );
  }
}

class NoteDetailScreen extends StatefulWidget {
  final String noteText;
  final int index;

  const NoteDetailScreen({
    super.key,
    required this.noteText,
    required this.index,
  });

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakText() async {
    await flutterTts.stop();
    await flutterTts.speak(widget.noteText);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  Future<void> deleteNote() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList('notes') ?? [];
    notes.removeAt(widget.index);
    await prefs.setStringList('notes', notes);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(
                  widget.noteText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: speakText,
              child: const Text("Read Aloud 🔊"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: stopSpeaking,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Stop ⛔"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: deleteNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Delete Note 🗑"),
            ),
          ],
        ),
      ),
    );
  }
}
