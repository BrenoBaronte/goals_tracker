import 'package:build/components/goal_tile.dart';
import 'package:build/models/goal.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Goal> goals = [
    Goal('English'),
    Goal('Flutter'),
    Goal('Exercises'),
    Goal('Final Project'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: goals.map(_createItem).toList(),
        ),
      ),
    );
  }

  Widget _createItem(Goal goal) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GoalTile(goal),
    );
  }
}


