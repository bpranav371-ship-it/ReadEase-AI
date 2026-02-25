import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Great Job, Leo!', style: TextStyle(color: AppColors.textMain, fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("You're becoming a reading superstar!", style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.borderLight)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.highlightYellow.withOpacity(0.2)),
                    child: const Icon(Icons.star, color: Color(0xFFEAB308), size: 40),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('TOTAL STARS', style: TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      Text('124', style: TextStyle(color: AppColors.textMain, fontSize: 36, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(child: _buildStatCard('5 Days', 'Streak', Icons.local_fire_department, AppColors.cardOrangeAccent, AppColors.cardOrange)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Lvl 7', 'Current Level', Icons.trending_up, const Color(0xFFA855F7), const Color(0xFFFAF5FF))),
              ],
            ),
            const SizedBox(height: 32),

            const Text('Your Badges', style: TextStyle(color: AppColors.textMain, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildBadgeCard('Star Reader', 'Read 5 books in a week', Icons.menu_book, const Color(0xFFEAB308), true),
            const SizedBox(height: 12),
            _buildBadgeCard('Quick Thinker', 'Completed a quiz in 2 mins', Icons.psychology, const Color(0xFFA855F7), true),
            const SizedBox(height: 12),
            _buildBadgeCard('Word Wizard', 'Learn 50 new words', Icons.school, AppColors.textMuted, false),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String subtitle, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: iconColor.withOpacity(0.2))),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildBadgeCard(String title, String subtitle, IconData icon, Color iconColor, bool isUnlocked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isUnlocked ? iconColor.withOpacity(0.15) : AppColors.borderLight, shape: BoxShape.circle),
            child: Icon(icon, color: isUnlocked ? iconColor : AppColors.textMuted, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isUnlocked ? AppColors.textMain : AppColors.textMuted, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
              ],
            ),
          ),
          Icon(isUnlocked ? Icons.check_circle : Icons.lock, color: isUnlocked ? AppColors.cardGreenAccent : AppColors.borderLight),
        ],
      ),
    );
  }
}