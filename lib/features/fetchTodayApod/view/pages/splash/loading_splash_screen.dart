import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLoadingScreen extends StatefulWidget {
  const SplashLoadingScreen({
    super.key,
  });

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
      'assets/splash_screen.json',
    ));
  }
}
