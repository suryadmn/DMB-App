import 'package:flutter/material.dart';

import '../../pages/authentication_page/login_page/login_page.dart';
import '../../pages/not_found_page/not_found_page.dart';
import '../../pages/splash_screen_page/splash_screen_page.dart';
import 'route_name.dart';

/// A class responsible for generating routes and handling navigation in the app.
class RouteGenerator {
  /// Generates the appropriate route based on the [RouteSettings].
  ///
  /// This method maps route names to corresponding widget pages. If the route
  /// name does not match any in the map, it will show the [NotFoundPage].
  ///
  /// - [settings]: The route settings that contain the route name and arguments.
  /// - Returns a [Route] that displays the matching page, or the [NotFoundPage] if no match.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    // Define available routes
    var routes = <String, WidgetBuilder>{
      // Splash screen route
      splashScreenRoute: (_) => const SplashScreenPage(),

      // Login route
      loginRoute: (_) => const LoginPage(),
    };

    // Get the widget builder for the route
    WidgetBuilder? builder = routes[settings.name];

    // Return the corresponding route or NotFoundPage if route doesn't exist
    return MaterialPageRoute(
        settings: RouteSettings(
          name: settings.name,
        ),
        builder: (ctx) =>
            builder == null ? const NotFoundPage() : builder(ctx));
  }

  /// A fallback route in case of an error.
  ///
  /// Displays the [NotFoundPage] if an error occurs during route generation.
  static Route<dynamic>? errorRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        return const NotFoundPage();
      },
    );
  }
}
