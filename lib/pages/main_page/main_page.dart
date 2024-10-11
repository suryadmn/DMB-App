import 'package:flutter/material.dart';

import 'home_page/home_page.dart';
import 'profile_page/profile_page.dart';

/// The main page that contains the bottom navigation bar.
///
/// This page allows users to switch between the home and profile sections of the app.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

/// State for the [MainPage].
class _MainPageState extends State<MainPage> {
  // The index of the currently selected tab.
  int currentIndex = 0;

  // List of widgets to display for each tab.
  final List<Widget> children = [
    const HomePage(), // Widget for the Home page
    const ProfilePage(), // Widget for the Profile page
  ];

  /// Handles the tab tapping event.
  ///
  /// Updates the current index to reflect the selected tab.
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index; // Update the current index based on user selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex], // Display the selected tab content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // Set the currently selected tab
        onTap: onTabTapped, // Handle tab changes
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for the Home tab
            label: 'Home', // Label for the Home tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icon for the Profile tab
            label: 'Profile', // Label for the Profile tab
          ),
        ],
      ),
    );
  }
}
