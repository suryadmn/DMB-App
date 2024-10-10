import 'package:flutter/material.dart';

import '../../pages/authentication_page/login_page/login_page.dart';
import '../../pages/not_found_page/not_found_page.dart';
import '../../pages/splash_screen_page/splash_screen_page.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    var routes = <String, WidgetBuilder>{
      // Splash screen route
      splashScreenRoute: (_) => const SplashScreenPage(),

      // Auth route
      loginRoute: (_) => const LoginPage(),
    };
    WidgetBuilder? builder = routes[settings.name];
    return MaterialPageRoute(
        settings: RouteSettings(
          name: settings.name,
        ),
        builder: (ctx) =>
            builder == null ? const NotFoundPage() : builder(ctx));
  }

  static Route<dynamic>? errorRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        return const NotFoundPage();
      },
    );
  }
}
