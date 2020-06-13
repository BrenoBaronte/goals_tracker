import 'package:build/screens/goal_edit_screen.dart';
import 'package:build/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Build';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(accentColor: Colors.amber),
      routes: {
        '/': (context) => Home(title: title,),
        '/edit': (context) => GoalEdit(),
      },
    );
  }
}