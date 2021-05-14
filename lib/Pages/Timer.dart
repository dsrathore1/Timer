import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timer/main.dart';

class Timers extends StatefulWidget {
  @override
  _TimersState createState() => _TimersState();
}

class _TimersState extends State<Timers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              backgroundColor: Colors.black,
              bottom: TabBar(
                indicatorWeight: 6.0,
                indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Timer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Stopwatch",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TimerPage(),
              StopwatchPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int val = 0;
  bool start = true;
  bool stop = true;
  bool reset = true;
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);
  String display = "00:00:00";

  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      display = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startsw() {
    setState(() {
      stop = false;
      start = false;
    });
    swatch.start();
    startTimer();
  }

  void stopsw() {
    setState(() {
      reset = false;
      stop = true;
    });
    swatch.stop();
  }

  void resetsw() {
    setState(() {
      start = true;
      reset = true;
    });
    swatch.reset();
    display = "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                display,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.teal,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          textStyle: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        onPressed: reset ? null : resetsw,
                        child: Text("Reset"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          textStyle: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        onPressed: stop ? null : stopsw,
                        child: Text("Stop"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: start ? startsw : null,
                    child: Text("Start"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 150),
                      textStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool stopped = true;
  bool started = true;
  int timefortimer = 0;
  String display = "00:00:00";
  bool checkTimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timefortimer = ((hour * 60 * 60) + (min * 60) + sec);

    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        setState(
          () {
            if (timefortimer < 1 || checkTimer == false) {
              checkTimer = true;
              t.cancel();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            } else if (timefortimer < 60) {
              display = timefortimer.toString();
              timefortimer = timefortimer - 1;
            } else if (timefortimer < 3600) {
              int m = timefortimer ~/ 60;
              int s = timefortimer - (60 * m);
              timefortimer = timefortimer - 1;
              display = m.toString() + ":" + s.toString();
            } else {
              int h = timefortimer ~/ 3600;
              int t = timefortimer - (3600 * h);
              int m = t ~/ (60);
              int s = t - (60 * m);
              display = h.toString() + ":" + m.toString() + ":" + s.toString();
              timefortimer = timefortimer - 1;
            }
            display = timefortimer.toString();
          },
        );
      },
    );
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    NumberPicker(
                      itemWidth: 90,
                      textStyle: TextStyle(fontSize: 18),
                      minValue: 0,
                      maxValue: 24,
                      value: hour,
                      selectedTextStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.green,
                      ),
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    NumberPicker(
                      itemWidth: 90,
                      textStyle: TextStyle(fontSize: 18),
                      minValue: 0,
                      haptics: true,
                      maxValue: 59,
                      value: min,
                      selectedTextStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.green,
                      ),
                      onChanged: (value) {
                        setState(() {
                          min = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    NumberPicker(
                      itemWidth: 90,
                      selectedTextStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.green,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                      minValue: 0,
                      maxValue: 59,
                      value: sec,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: Center(
              child: Text(
                this.display,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: started ? start : null,
                      child: Text("Start"),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      onPressed: stopped ? null : stop,
                      child: Text("Stop"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
