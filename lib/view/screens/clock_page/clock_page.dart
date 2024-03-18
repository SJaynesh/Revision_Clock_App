import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  bool isDigital = false;
  bool isAnalog = false;
  bool isStrap = false;
  bool isTimer = false;
  bool isReverse = false;

  bool isTimerClock = false;

  int hour = 0;
  int minute = 0;
  int second = 0;

  List<Map<String, dynamic>> timerHistory = [];

  int h = 00;
  int m = 00;
  int s = 00;

  void timerClock() {
    isTimerClock = true;
    Future.delayed(
      const Duration(microseconds: 1),
      () {
        setState(() {
          if (isTimerClock) {
            s++;
          }
          if (s > 59) //  60 > 59
          {
            m++;
            s = 0;
          }
          if (m > 59) {
            h++;
            m = 0;
          }

          if (h > 12) {
            h = 0;
          }
        });
        if (isTimerClock) {
          timerClock();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.textScalerOf(context);
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    double width = size.width;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        DateTime dateTime = DateTime.now();
        hour = dateTime.hour;
        minute = dateTime.minute;
        second = dateTime.second;
      });
    });
    return Scaffold(
      drawer: Drawer(
        // backgroundColor: Colors.grey,
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Jenish Kanudo"),
              accountEmail: Text("jenish@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/132265451?v=4"),
              ),
              // currentAccountPictureSize: Size(80, 80),
            ),
            ListTile(
              leading: const Text("01"),
              title: const Text("Digital Clock"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isDigital,
                onChanged: (val) {
                  isDigital = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("02"),
              title: const Text("Analog Clock"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isAnalog,
                onChanged: (val) {
                  isAnalog = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("03"),
              title: const Text("Strap Watch"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isStrap,
                onChanged: (val) {
                  isStrap = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("04"),
              title: const Text("Timer"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isTimer,
                onChanged: (val) {
                  isTimer = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("05"),
              title: const Text("Reverse Time"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isReverse,
                onChanged: (val) {
                  isReverse = val;
                  setState(() {});
                },
              ),
            ),
            const ListTile(
              leading: Text("06"),
              title: Text("Background Image"),
              subtitle: Text("clock"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Clock App"),
        // backgroundColor: Colors.primaries[second % 18].shade300,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: isAnalog,
                child: Stack(
                  children: [
                    ...List.generate(
                      60,
                      (index) => Transform.rotate(
                        angle: index * (pi * 2) / 60,
                        child: Divider(
                          color: (index % 5 == 0) ? Colors.red : Colors.grey,
                          thickness: (index % 5 == 0) ? 4 : 2,
                          indent: (index % 5 == 0) ? h * 0.39 : h * 0.41,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isAnalog,
                child: CircleAvatar(
                  radius: width * 0.015,
                  backgroundColor: Colors.black26,
                ),
              ),

              // Second

              Visibility(
                visible: isAnalog,
                child: Transform.rotate(
                  angle: second * (pi * 2) / 60 + pi / 2,
                  child: Divider(
                    color: Colors.redAccent,
                    thickness: 2,
                    indent: width * 0.09,
                    endIndent: width * 0.4,
                  ),
                ),
              ),

              // Minute
              Visibility(
                visible: isAnalog,
                child: Transform.rotate(
                  // Rotate for 90°
                  angle: pi / 2,
                  child: Transform.rotate(
                    angle: minute * (pi * 2) / 60,
                    child: Divider(
                      color: Colors.blue,
                      thickness: 3,
                      indent: width * 0.15,
                      endIndent: width * 0.45,
                    ),
                  ),
                ),
              ),

              // hour
              Visibility(
                visible: isAnalog,
                child: Transform.rotate(
                  angle: pi / 2,
                  child: Transform.rotate(
                    angle: hour * (pi * 2) / 12,
                    child: Divider(
                      color: Colors.black54,
                      thickness: 5,
                      indent: width * 0.25,
                      endIndent: width * 0.45,
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: isDigital,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: height * 0.086,
                      width: width * 0.2,
                      margin: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(width * 0.035),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                (hour % 12).toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: textScaler.scale(25),
                                  fontWeight: FontWeight.w800,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ),
                          const Text("Hour")
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.086,
                      width: width * 0.2,
                      margin: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(width * 0.035),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                (minute).toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: textScaler.scale(25),
                                  fontWeight: FontWeight.w800,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ),
                          const Text("Minute")
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.086,
                      width: width * 0.2,
                      margin: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(width * 0.035),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                (second).toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: textScaler.scale(25),
                                  fontWeight: FontWeight.w800,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ),
                          const Text("Second")
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: height * 0.03,
                          width: width * 0.07,
                          margin: EdgeInsets.only(top: height * 0.055),
                          padding: EdgeInsets.all(height * 0.001),
                          color: Colors.orange.withOpacity(0.5),
                          alignment: Alignment.center,
                          child: Text((hour < 12) ? 'AM' : 'PM'),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Strap Watch

              // second
              Visibility(
                visible: isStrap,
                child: Transform.scale(
                  scale: 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: second / 60,
                    color: Colors.redAccent,
                  ),
                ),
              ),

              // Minute
              Visibility(
                visible: isStrap,
                child: Transform.scale(
                  scale: 7,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: minute / 60,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Hour
              Visibility(
                visible: isStrap,
                child: Transform.scale(
                  scale: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: (hour % 12) / 12,
                    color: Colors.black54,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: textScaler.scale(35),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!isTimerClock) {
                            timerClock();
                          }
                          setState(() {});
                        },
                        child: const Text("Start"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          isTimerClock = false;
                          timerHistory.add({
                            'hour': h,
                            'minute': m,
                            'second': s,
                          });
                          setState(() {});
                        },
                        child: const Text("Stop"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          isTimerClock = false;
                          s = m = h = 0;
                        },
                        child: const Text("Restart"),
                      ),
                    ],
                  ),
                  ...timerHistory
                      .map((e) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${e['hour']}",
                                    style: TextStyle(
                                      fontSize: textScaler.scale(20),
                                    ),
                                  ),
                                  Text(
                                    "${e['minute']}",
                                    style: TextStyle(
                                      fontSize: textScaler.scale(20),
                                    ),
                                  ),
                                  Text(
                                    "${e['second']}",
                                    style: TextStyle(
                                      fontSize: textScaler.scale(20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList()
                ],
              )
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.primaries[second % 18].shade300,
    );
  }
}
