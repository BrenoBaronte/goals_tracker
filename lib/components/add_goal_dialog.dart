import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
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
                              int.parse(value);
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
            // count unit area
            Flexible(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        TextFormField(
                          controller: _countUnitController,
                          decoration:
                              InputDecoration(hintText: 'Count measure'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a count measure';
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
            // feeling area // todo: do it right
            Flexible(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('Feeling', style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 10.0),
                      Icon(Icons.sentiment_very_satisfied),
                    ],
                  ),
                ),
              ),
            ),
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
                            Icons.sentiment_very_satisfied.codePoint,
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
