import 'package:flutter/material.dart';
import 'package:rotating_text/components/LinearText.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOnRight(double rotation) => math.cos(rotation) < 0;
  bool isOnLeft(double rotation) => math.cos(rotation) > 0; //<---- check if angle is on the left

  @override
  Widget build(BuildContext context) {
    final numberOfTexts = 20;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            numberOfTexts,
                (index) {
                  double rotation =
                      2 * math.pi * index / numberOfTexts + math.pi / 2; //<----add 90 degrees
                  if (isOnLeft(rotation)) {
                    rotation = -rotation;       //<----flip on the left side
                  }
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotation)   //<----use the updated rotation
                      ..translate(-120.0),
                    child: LinearText(),
                  );
            },
          ),
        ),
      ),
    );
  }
}