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
    );
  }

//  Widget _createItem(Goal goal) {
//    return Padding(
//      padding: const EdgeInsets.all(16.0),
//      child: GoalTile(goal),
//    );
//  }
}
