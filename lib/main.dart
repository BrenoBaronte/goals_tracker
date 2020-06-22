import 'dart:async';

//import 'package:build/database/dao/goal_dao.dart';
import 'package:build/screens/edit_goal_screen.dart';
import 'package:build/screens/home_screen.dart';
import 'package:build/sentry_settings.dart';
import 'package:flutter/material.dart';

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZonedGuarded<Future<Null>>(() async {
    runApp(MyApp());
//    GoalDao().findAll().then((value) => debugPrint(value.toString()));
  }, (error, stackTrace) async {
    await reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  final String title = 'Build';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(accentColor: Colors.amber[400]),
      routes: {
        '/': (context) => Home(
              title: title,
            ),
        '/edit': (context) => GoalEdit(),
      },
    );
  }
}
