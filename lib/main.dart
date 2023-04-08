import 'package:flutter/material.dart';
import 'Screens/GetStarted/UI/GetStartedPage.dart';

void main() {
  runApp(MaterialApp(title: 'hackathon', home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),
    );
  }
}
