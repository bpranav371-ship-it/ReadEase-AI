import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool soundEffects = true;
  double ttsSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [Icon(Icons.notifications), SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 4), image: const DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?img=11'), fit: BoxFit.cover)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.edit, color: Colors.white, size: 20),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Leo', style: TextStyle(color: AppColors.textMain, fontSize: 32, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: const Text('LEVEL 7', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.borderLight)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star, color: Color(0xFFEAB308)),
                  SizedBox(width: 8),
                  Text('124 Stars earned', style: TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Align(alignment: Alignment.centerLeft, child: const Text('LEARNING EXPERIENCE', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12))),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.borderLight)),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.volume_up, color: AppColors.primary)),
                    title: const Text('Sound Effects', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                    trailing: Switch(value: soundEffects, onChanged: (val) => setState(() => soundEffects = val), activeColor: AppColors.primary),
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.speed, color: AppColors.primary)),
                            const SizedBox(width: 16),
                            const Text('Text-to-Speech Speed', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Slider(value: ttsSpeed, min: 0.5, max: 2.0, divisions: 3, activeColor: AppColors.primary, inactiveColor: AppColors.borderLight, onChanged: (val) => setState(() => ttsSpeed = val)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('SLOW', style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold)),
                            Text('NORMAL', style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold)),
                            Text('FAST', style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            Align(alignment: Alignment.centerLeft, child: const Text('ACCOUNT', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12))),
            const SizedBox(height: 12),
            _buildAccountTile('Change Avatar', Icons.face),
            const SizedBox(height: 12),
            _buildAccountTile('Parent Dashboard', Icons.family_restroom),
            const SizedBox(height: 32),
            const Text('Log Out', style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTile(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.borderLight)),
      child: ListTile(
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppColors.primary)),
        title: Text(title, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      ),
    );
  }
}