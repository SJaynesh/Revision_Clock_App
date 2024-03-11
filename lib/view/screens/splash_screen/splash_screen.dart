import 'dart:async';

import 'package:flutter/material.dart';
import 'package:revision_clock_app/utills/globals/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimated = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        isAnimated = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 6),
      () {
        Navigator.of(context).pushReplacementNamed(Routes.homePage);
      },
    );
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 4),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: (isAnimated)
              ? Image(
                  key: UniqueKey(),
                  image: const AssetImage(
                      "assets/images/splash_screen/splash_image.png"),
                  height: 200,
                )
              : Image(
                  key: UniqueKey(),
                  image: const AssetImage(
                      "assets/images/splash_screen/splash_image_2.png"),
                ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     isAnimated = !isAnimated;
      //     setState(() {});
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
