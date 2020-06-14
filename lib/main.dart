import 'package:build/database/app_database.dart';
import 'package:build/models/goal.dart';
import 'package:build/screens/goal_edit_screen.dart';
import 'package:build/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
//  save(Goal(0, 'Goal Title', 0, 'Days', Icons.sentiment_very_satisfied.codePoint))
//      .then((id) {
//        findAll().then((goals) => debugPrint(goals.toString()));
//  });
findAll().then((value) => debugPrint(value.toString()));
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
        '/': (context) => Home(
              title: title,
            ),
        '/edit': (context) => GoalEdit(),
      },
    );
  }
}
