import 'package:flutter/material.dart';
import 'package:music_recommendation/src/ui/homepage/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musimotion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Lato",
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
