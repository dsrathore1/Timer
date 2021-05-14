import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

import 'package:timer/Pages/Homepage.dart';
import 'package:timer/Pages/Settings.dart';
import 'Pages/Timer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black87,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.black,
      statusBarColor: Colors.black87,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Timer",
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _index = 1;
  List _tab = [
    HomePage(),
    Timers(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_open),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Timer",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: "Cursive",
                color: Colors.white),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          backgroundColor: Colors.white,
          index: _index,
          color: Colors.black,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 500),
          // buttonBackgroundColor: Colors.white,
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.timer,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        body: _tab[_index],
      ),
    );
  }
}
