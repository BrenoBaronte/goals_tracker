import 'package:build/models/goal.dart';
import 'package:build/screens/goal_edit_screen.dart';
import 'package:flutter/material.dart';

class GoalTile extends StatefulWidget {
  final Goal goal;

  GoalTile(this.goal);

  @override
  _GoalTileState createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              widget.goal.count.toString(),
              style: _titleTextStyle,
              overflow: TextOverflow.fade,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              widget.goal.title,
              style: _titleTextStyle,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                widget.goal.countUnit.toString(),
                style: _tileTextStyle,
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Text(
                    'Feeling',
                    style: _tileTextStyle,
                  ),
                  Expanded(
                    child: Icon(
                        widget.goal.feeling
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          GoalEdit(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final TextStyle _titleTextStyle = TextStyle(
  fontSize: 22.0, letterSpacing: 1.0,);

final TextStyle _tileTextStyle = TextStyle(
    fontSize: 18,
    letterSpacing: 1.0,
    fontWeight: FontWeight.w400);
