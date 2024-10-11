import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'datas/routes/route_generator.dart';
import 'datas/routes/route_name.dart';
import 'providers/provider_auth.dart';
import 'providers/provider_home.dart';
import 'providers/provider_profile.dart';
import 'utils/color_pallete_helper.dart';

void main() {
  // Initialize the application with MultiProvider for state management.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProviderAuth>(
        create: (_) => ProviderAuth(), // Provide the authentication provider
      ),
      ChangeNotifierProvider<ProviderProfile>(
        create: (_) => ProviderProfile(), // Provide the profile provider
      ),
      ChangeNotifierProvider<ProviderHome>(
        create: (_) => ProviderHome(), // Provide the home provider
      ),
    ],
    child: const DMBApps(), // Entry point of the application
  ));
}

/// The main application widget.
///
/// This widget sets up the MaterialApp with the necessary themes, routes, and initial configurations.
class DMBApps extends StatelessWidget {
  const DMBApps({super.key});

  /// Builds the main structure of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMB Apps', // Title of the application
      theme: ThemeData.light().copyWith(
        primaryColor:
            ColorPalleteHelper.primary500, // Primary color for light theme
        colorScheme: const ColorScheme.light(
          primary: ColorPalleteHelper.primary500, // Primary color light
          secondary: ColorPalleteHelper.primary100, // Secondary color light
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontFamily: 'Poppins', // Font family for small text
            color: ColorPalleteHelper.black,
            fontSize: 12,
          ), // Small body text
          bodyMedium: TextStyle(
            fontFamily: 'Poppins', // Font family for medium text
            color: ColorPalleteHelper.black,
            fontSize: 14,
          ), // Medium body text
          bodyLarge: TextStyle(
            fontFamily: 'Poppins', // Font family for large text
            color: ColorPalleteHelper.black,
            fontSize: 16,
          ), // Large body text
          headlineMedium: TextStyle(
            fontFamily: 'Poppins', // Font family for medium headlines
            fontSize: 24,
            color: ColorPalleteHelper.black,
            fontWeight: FontWeight.bold,
          ), // Medium headline style
          headlineLarge: TextStyle(
            fontFamily: 'Poppins', // Font family for large headlines
            fontSize: 28,
            color: ColorPalleteHelper.black,
            fontWeight: FontWeight.bold,
          ), // Large headline style
        ),
      ), // Light theme configuration
      darkTheme: ThemeData.dark(), // Configuration for dark theme
      themeMode: ThemeMode
          .system, // Automatically switch between light and dark themes based on system settings
      onUnknownRoute: RouteGenerator.errorRoute, // Handle unknown routes
      onGenerateRoute:
          RouteGenerator.generateRoute, // Route generation based on route names
      initialRoute:
          splashScreenRoute, // Initial route to display when the app starts
    );
  }
}
