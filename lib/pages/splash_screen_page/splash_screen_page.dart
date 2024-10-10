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
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      Navigator.pushReplacementNamed(context, loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is a splash screen page'),
      ),
    );
  }
}
