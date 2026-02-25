import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/services/analytics_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the singleton service that tracks taps during reading sessions
    final AnalyticsService analytics = AnalyticsService();
    final struggleWords = analytics.getStruggleWords();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Reading Insights", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: LEARNING STATS ---
            const Text("Quick Stats", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMetricCard("Words Helped", "${struggleWords.length}", Icons.help_center_rounded, Colors.orange),
                const SizedBox(width: 12),
                _buildMetricCard("Focus Score", "85%", Icons.bolt_rounded, Colors.blue),
              ],
            ),

            const SizedBox(height: 32),

            // --- SECTION 2: VISUAL TREND CHART (MOCK) ---
            const Text("Reading Friction Trend", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  const Text("Taps per Session", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar(40, "Mon"),
                      _buildBar(70, "Tue"),
                      _buildBar(30, "Wed"),
                      _buildBar(90, "Thu"),
                      _buildBar(50, "Fri"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- SECTION 3: STRUGGLE WORDS LIST ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Words to Practice", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("${struggleWords.length} Words", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),

            struggleWords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: struggleWords.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.spellcheck_rounded, color: AppColors.primary),
                    title: Text(struggleWords[index],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for Stats
  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  // Helper widget for Chart Bars
  Widget _buildBar(double height, String label) {
    return Column(
      children: [
        Container(
          height: height,
          width: 15,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: const [
          SizedBox(height: 40),
          Icon(Icons.auto_awesome, size: 50, color: AppColors.borderLight),
          SizedBox(height: 16),
          Text("No tricky words found!", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Keep reading to build your profile.", style: TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}