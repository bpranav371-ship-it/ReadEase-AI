import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/services/analytics_service.dart';

class DashboardScreen extends StatelessWidget {
  final AnalyticsService analytics = AnalyticsService();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get words tapped more than once
    final struggleWords = analytics.getStruggleWords();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("My Reading Progress")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tricky Words", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("These are words you tapped for help:", style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 20),
            Expanded(
              child: struggleWords.isEmpty
                  ? const Center(child: Text("No tricky words yet! Keep reading!"))
                  : ListView.builder(
                itemCount: struggleWords.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: const Icon(Icons.help_outline, color: AppColors.primary),
                      title: Text(struggleWords[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      trailing: const Text("Needs Practice", style: TextStyle(color: Colors.redAccent)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}