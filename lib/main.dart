import 'package:flutter/material.dart';
import 'package:music_recommendation/src/ui/homepage/homePage.dart';
import 'package:music_recommendation/src/ui/recommendation/recommendation_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musiemotion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Lato",
      ),
      home: RecommendationPage(
        emotion: "Happy",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
