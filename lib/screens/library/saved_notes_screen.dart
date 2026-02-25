import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/services/database_service.dart';
import 'package:readease/screens/reading/reading_screen.dart';

class SavedNotesScreen extends StatelessWidget {
  const SavedNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = DatabaseService.savedNotes;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("My Library", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes saved yet. Tap 'Save' in a session!"))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 tabs per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Clicking the tab opens the full word-by-word reader
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingScreen(
                    initialText: notes[index]['content']!,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                ],
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.primary, size: 32),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      notes[index]['title'] ?? "Note",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(notes[index]['date'] ?? "", style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}