import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'datas/routes/route_generator.dart';
import 'datas/routes/route_name.dart';
import 'providers/provider_auth.dart';
import 'utils/color_pallete_helper.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProviderAuth>(
        create: (_) => ProviderAuth(),
      ),
    ],
    child: const DMBApps(),
  ));
}

class DMBApps extends StatelessWidget {
  const DMBApps({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMB Apps',
      theme: ThemeData.light().copyWith(
        primaryColor: ColorPalleteHelper.primary500, // Primary color
        colorScheme: const ColorScheme.light(
          primary: ColorPalleteHelper.primary500, // Primary color light
          secondary: ColorPalleteHelper.primary100, // Secondary color light
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontFamily: 'Poppins',
            color: ColorPalleteHelper.black,
            fontSize: 12,
          ), // Small body text
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            color: ColorPalleteHelper.black,
            fontSize: 14,
          ), // Medium body text
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            color: ColorPalleteHelper.black,
            fontSize: 16,
          ), // Large body text
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            color: ColorPalleteHelper.black,
            fontWeight: FontWeight.bold,
          ), // Medium headline style
          headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
            color: ColorPalleteHelper.black,
            fontWeight: FontWeight.bold,
          ), // Medium headline style
        ),
      ), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system, // Use system theme mode (auto switch)
      onUnknownRoute: RouteGenerator.errorRoute, // Unknown page
      onGenerateRoute: RouteGenerator.generateRoute, // Generate route list
      initialRoute: splashScreenRoute, // Initial page
    );
  }
}
