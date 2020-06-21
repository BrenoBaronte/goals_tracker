import 'package:flutter/material.dart';

class GoalEdit extends StatefulWidget {
  @override
  _GoalEditState createState() => _GoalEditState();
}

class _GoalEditState extends State<GoalEdit> {
  final String appBarTitle = 'Edit';
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // title area
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['title'],
                              style: TextStyle(
                                fontSize: 32.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // count and feeling areas
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        // count area
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    data['count'],
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Flexible(
                                  child: Text(
                                    data['countUnit'],
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // feeling area
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  IconData(
                                    data['feeling'],
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 30.0,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Feeling',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
              ),
            ),
          ],
        ),
      ),
    );
  }
}
