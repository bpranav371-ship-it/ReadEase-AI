import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/screens/home/home_screen.dart';
import 'package:readease/screens/dashboard/dashboard_screen.dart'; // Ensure this path exists
import 'package:readease/screens/library/saved_notes_screen.dart';
import 'package:readease/screens/profile/profile_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DashboardScreen(), // Dashboard now lives in the main menu
    const SavedNotesScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppColors.surfaceLight,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          showUnselectedLabels: true,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 28), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded, size: 28), label: 'Progress'), // Dashboard
            BottomNavigationBarItem(icon: Icon(Icons.collections_bookmark_rounded, size: 28), label: 'Library'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded, size: 28), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}