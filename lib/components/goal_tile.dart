import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
import 'package:flutter/material.dart';

class GoalTile extends StatefulWidget {
  final Goal goal;

  GoalTile(this.goal);

  @override
  _GoalTileState createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  final GoalDao _goalDao = GoalDao();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
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
              flex: 2,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        widget.goal.increment();
                        _goalDao.updateCount(widget.goal);
                        setState(() {});
                      },
                      child: Row(
                        children: <Widget>[
                          Text('Add', style: _tileTextStyle),
                          SizedBox(width: 10),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(

                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit',
                          arguments: {
                            'title': widget.goal.title,
                            'feeling': widget.goal.feeling,
                            'count': widget.goal.count.toString(),
                            'countUnit': widget.goal.countUnit,
                          },
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Text('Edit', style: _tileTextStyle),
                          SizedBox(width: 10),
                          Icon(Icons.launch)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final TextStyle _titleTextStyle = TextStyle(
  fontSize: 22.0,
  letterSpacing: 1.0,
);

final TextStyle _tileTextStyle = TextStyle(
  fontSize: 18,
  letterSpacing: 1.0,
  fontWeight: FontWeight.w400,
);
