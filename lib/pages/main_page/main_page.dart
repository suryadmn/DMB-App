import 'package:dmb_app/providers/provider_home.dart';
import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Stack(
        children: [
          children[currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible:
                  Provider.of<ProviderHome>(context).isLoadingDownloadImage,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color: ColorPalleteHelper.primary100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Downloading... ${Provider.of<ProviderHome>(context).downProgress.toInt()}%",
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const LinearProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ), // Display the selected tab content
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
