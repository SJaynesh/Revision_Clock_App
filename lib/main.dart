import 'package:flutter/material.dart';
import 'package:revision_clock_app/utills/globals/routes.dart';
import 'package:revision_clock_app/view/screens/clock_page/clock_page.dart';
import 'package:revision_clock_app/view/screens/home_page/home_page.dart';
import 'package:revision_clock_app/view/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(
    const ClockApp(),
  );
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.homePage: (context) => const HomePage(),
        Routes.clockPage: (context) => const ClockPage(),
      },
    );
  }
}
