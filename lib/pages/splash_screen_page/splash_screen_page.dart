import 'package:dmb_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

import '../../datas/routes/route_name.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // Initialize data
    initialize();
    super.initState();
  }

  void initialize() {
    SharedPreferencesHelper.getHasLogin(
            key: SharedPreferencesHelper.prefsHasLoginKey)
        .then((hasLoginValue) {
      if (hasLoginValue) {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          Navigator.pushReplacementNamed(context, mainRoute);
        });
      } else {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          Navigator.pushReplacementNamed(context, loginRoute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 54),
      ),
    );
  }
}
