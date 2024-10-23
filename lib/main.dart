import 'package:flutter/material.dart';
import 'sunrise_sunset_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunrise & Sunset',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light
      ),
      home: SunriseSunsetPage(),
    );
  }
}
