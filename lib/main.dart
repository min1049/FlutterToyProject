import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/make_room.dart';
import 'package:untitled2/make_room2.dart';
import 'package:untitled2/start_page.dart';
import 'package:untitled2/test_stomp.dart';
import 'package:untitled2/tests/json_parse.dart';
import 'package:untitled2/tests/dio_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/tests/ws_server.dart';
import 'package:untitled2/tests/ws_stomp_server.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(246,247,251,1),
        //primarySwatch: Colors.orange,
        fontFamily: 'cafe',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectPlayerState()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/splash.gif'), fit: BoxFit.contain),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



