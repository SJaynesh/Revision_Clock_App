import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utills/globals/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double progress = 0;
  double containerSize = 400;
  int index = 0;
  double angle = 0;

  Future<void> progressBar() async {
    await Timer.periodic(const Duration(seconds: 1), (timer) {
      if (progress < 1) {
        progress += 0.01;
      } else {
        progress = 0;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    progressBar();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 0), (timer) {
      angle = index * (pi * 2) / 60;
      if (index < 60) {
        index++;
      } else {
        index = 0;
      }
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.clockPage);
            },
            icon: const Icon(Icons.watch_later),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(
              height: 50,
            ),
            // Transform.scale(
            //   // scale: 3,
            //   scaleX: 3,
            //   scaleY: 3,
            //   child: CircularProgressIndicator(
            //     backgroundColor: Colors.grey.shade200,
            //     color: Colors.blue,
            //     strokeWidth: 4,
            //     value: progress,
            //   ),
            // ),
            Transform.translate(
              offset: const Offset(-50, -300),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey.shade200,
                color: Colors.blue,
                strokeWidth: 4,
                value: progress,
              ),
            ),

            GestureDetector(
              onTap: () {
                containerSize += 50;
                index++;
                setState(() {});
              },
              onDoubleTap: () {
                containerSize -= 50;
                index--;
                setState(() {});
              },
              child: Transform.rotate(
                angle: angle,
                child: AnimatedContainer(
                  height: containerSize,
                  width: containerSize,
                  duration: const Duration(seconds: 1),
                  decoration: const BoxDecoration(
                    // color: Colors.primaries[index % 18],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Earth_Western_Hemisphere_transparent_background.png/1200px-Earth_Western_Hemisphere_transparent_background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Container",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
