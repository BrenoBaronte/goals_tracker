import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGoalDialog extends StatefulWidget {
  final Function callback;

  AddGoalDialog(this.callback);

  @override
  _AddGoalDialogState createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final GoalDao _goalDao = GoalDao();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _countController =
      TextEditingController(text: '0');
  final TextEditingController _countUnitController =
      TextEditingController(text: 'Days');

  int _currentFeeling = 3;
  int _currentFeelingIcon = 59410;
  int _currentColorStrength = 300;

  _setIconCodePoint(int currentFeeling) {
    switch (currentFeeling) {
      case 1:
        _currentFeelingIcon = Icons.sentiment_very_dissatisfied.codePoint;
        _currentColorStrength = 100;
        break;
      case 2:
        _currentFeelingIcon = Icons.sentiment_dissatisfied.codePoint;
        _currentColorStrength = 200;
        break;
      case 3:
        _currentFeelingIcon = Icons.sentiment_neutral.codePoint;
        _currentColorStrength = 300;
        break;
      case 4:
        _currentFeelingIcon = Icons.sentiment_satisfied.codePoint;
        _currentColorStrength = 400;
        break;
      case 5:
        _currentFeelingIcon = Icons.sentiment_very_satisfied.codePoint;
        _currentColorStrength = 500;
        break;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _countController.dispose();
    _countUnitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 0,
              title: Text('New Goal'),
              centerTitle: true,
            ),
            // title input area
            Flexible(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: 'Title of the new goal'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // count input area
            Flexible(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        TextFormField(
                          controller: _countController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: 'Initial count value'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a count value';
                            }
                            try {
                              if (int.parse(value) < 0)
                                return 'Please enter a positive value';
                            } catch (e) {
                              return 'Please enter a numeric value';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
// todo count and input area - implement edit first
//            // count unit area
//            Flexible(
//              child: Container(
//                child: Center(
//                  child: Padding(
//                    padding: EdgeInsets.all(10.0),
//                    child: Wrap(
//                      children: <Widget>[
//                        TextFormField(
//                          controller: _countUnitController,
//                          decoration:
//                              InputDecoration(hintText: 'Count measure'),
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter a count measure';
//                            }
//                            return null;
//                            // feeling area
//                          },
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            // feeling area
//            Flexible(
//              child: Container(
//                child: Wrap(
//                  alignment: WrapAlignment.center,
//                  crossAxisAlignment: WrapCrossAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      IconData(
//                        _currentFeelingIcon,
//                        fontFamily: 'MaterialIcons',
//                      ),
//                    ),
//                    Slider(
//                      activeColor: Colors.amber[(_currentColorStrength ?? 400)],
//                      inactiveColor: Colors.white,
//                      value: (_currentFeeling ?? 3).toDouble(),
//                      max: 5,
//                      min: 1,
//                      divisions: 4,
//                      onChanged: (value) {
//                        setState(() {
//                          _currentFeeling = value.round();
//                          _setIconCodePoint(_currentFeeling);
//                        });
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ),
            // create button
            Flexible(
              child: Center(
                child: MaterialButton(
                    color: Colors.amber[400],
                    elevation: 1,
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.grey[900], fontSize: 18),
                    ),
                    onPressed: () {
                      try {
                        if (_formKey.currentState.validate()) {
                          final goal = Goal(
                            0,
                            _titleController.text,
                            int.parse(_countController.text),
                            _countUnitController.text,
                            _currentFeelingIcon,
                          );
                          _goalDao.save(goal);
                          this.widget.callback();
                          Navigator.pop(context);
                        } else {}
                      } catch (e) {
                        // todo: add sentry
                        print('deu ruim');
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
