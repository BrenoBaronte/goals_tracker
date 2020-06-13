import 'package:flutter/material.dart';

class GoalEdit extends StatefulWidget {
  @override
  _GoalEditState createState() => _GoalEditState();
}

class _GoalEditState extends State<GoalEdit> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(data['title']),
              Text(data['count']),
              Text(data['countUnit']),
              Icon(IconData(data['feeling'], fontFamily: 'MaterialIcons'))
            ],
          ),
        ),
      ),
    );
  }
}
