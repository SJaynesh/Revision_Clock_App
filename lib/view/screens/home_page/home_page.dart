import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double progress = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
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
          ],
        ),
      ),
    );
  }
}
