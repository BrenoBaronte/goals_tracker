import 'package:build/components/goal_tile.dart';
import 'package:build/database/dao/goal_dao.dart';
import 'package:build/models/goal.dart';
import 'file:///C:/Users/breno/AndroidStudioProjects/build/lib/components/add_goal_dialog.dart';
import 'file:///C:/Users/breno/AndroidStudioProjects/build/lib/components/delete_goal_dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoalDao _goalDao = GoalDao();
  List<Goal> goals = List();

  void callback() {
    setState(() {});
  }

  void removeCallback(Goal goal) {
    setState(() {
      _goalDao.remove(goal.id);
      goals.remove(goal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
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
                  goals = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Goal goal = goals[index];
                      return Dismissible(
                          key: Key(goal.id.toString()),
                          onDismissed: (direction) async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return DeleteGoalDialog(
                                    this.callback, this.removeCallback, goal);
                              },
                            );
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
                child: AddGoalDialog(this.callback),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white12,
        child: Container(height: 50.0),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}