import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/screens/scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hello,', style: TextStyle(color: AppColors.textMain, fontSize: 20)),
                    Text('Buddy!', style: TextStyle(color: AppColors.textMain, fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
                const CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'))
              ],
            ),
            const SizedBox(height: 30),

            const Text('What do you want to\n', style: TextStyle(color: AppColors.textMain, fontSize: 24, fontWeight: FontWeight.bold, height: 0.5)),
            const Text('do today?', style: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            _buildActivityCard(
              'Reading',
              'Practice stories',
              Icons.menu_book,
              AppColors.cardBlue,
              AppColors.cardBlueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScannerScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildActivityCard('Writing', "Let's write", Icons.edit, AppColors.cardGreen, AppColors.cardGreenAccent),
            const SizedBox(height: 16),

            _buildActivityCard('Games', 'Play time', Icons.sports_esports, AppColors.cardOrange, AppColors.cardOrangeAccent),

            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Your Progress', style: TextStyle(color: AppColors.textMain, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Level 4', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.star, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Daily Goal', style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Keep it up!', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: AppColors.borderLight,
                    color: AppColors.primary,
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('0%', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      Text('75%', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('100%', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String subtitle, IconData icon, Color bgColor, Color accentColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border(left: BorderSide(color: accentColor, width: 8)),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: accentColor.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: accentColor, size: 32),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}