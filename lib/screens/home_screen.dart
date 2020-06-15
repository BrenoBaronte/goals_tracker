import 'package:build/components/goal_tile.dart';
import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  final GoalDao _goalDao = GoalDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Goal>>(
            initialData: List(),
            future: _goalDao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('loading...'),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  final List<Goal> goals = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Goal goal = goals[index];
                      return GoalTile(goal);
                    },
                    itemCount: goals.length,
                  );
                  break;
              }

              return Text('Unknown error');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: AddGoalDialog(),
              );
            },
          );
        },
      ),
    );
  }
}

class AddGoalDialog extends StatefulWidget {
  @override
  _AddGoalDialogState createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _formKey = GlobalKey<FormState>();

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
                              var number = int.parse(value);
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
                    color: Colors.amber,
                    elevation: 1,
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('object');
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(_titleController.text +
                                    ' - ' +
                                    _countController.text +
                                    ' - ' +
                                    _countUnitController.text),
                              );
                            });
                      } else {
                        print('xi');
                        return null;
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
