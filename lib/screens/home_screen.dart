import 'package:build/components/goal_tile.dart';
import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoalDao _goalDao = GoalDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      return Dismissible(
                          key: Key(goal.id.toString()),
                          onDismissed: (direction) async {

                            bool sure;
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  child: Container(
                                    width: 300.0,
                                    height: 200.0,
                                    child: Column(
                                      children: <Widget>[
                                        Text('Are you sure?'),
                                        Row(
                                          children: <Widget>[
                                            MaterialButton(
                                              onPressed: () {
                                                sure = false;
                                                Navigator.pop(context);
                                              },
                                              child: Text('No'),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                sure = true;
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            print(sure);

//                            setState(() {
//                              _goalDao.remove(goal.id);
//                              goals.remove(goal);
//                            });
                          },
                          child: GoalTile(goal));
                    },
                    itemCount: goals.length,
                  );
                  break;
              }

              return Text('Unknown error');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        child: Icon(
          Icons.add,
          color: Colors.grey[900],
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
                child: AddGoalDialog(this),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white10,
        child: Container(height: 50.0),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AddGoalDialog extends StatefulWidget {
  final _HomeState parent;

  AddGoalDialog(this.parent);

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
            // count input area // todo: trim 0 on left
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
                          this.widget.parent.setState(() {});
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
