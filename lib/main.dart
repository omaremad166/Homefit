import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homefit/home_page.dart';
import 'package:homefit/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        primaryColor: Color(0xff215AED),
      ),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  checkStatus() async {
    sp = await SharedPreferences.getInstance();
    if (sp.getBool('first') == null) {
      sp.setBool('first', true);
      return Timer(Duration(seconds: 4), navigateSplash());
    } else {
      return Timer(Duration(seconds: 4), navigateHome());
    }
  }

  navigateSplash() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => OnBoardingPage()));
  }

  navigateHome() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.red,
      ),
    );
  }
}

