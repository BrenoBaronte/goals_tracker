import 'package:build/database/app_database.dart';
import 'package:build/models/goal.dart';
import 'package:sqflite/sqlite_api.dart';

class GoalDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_title TEXT, '
      '$_count INTEGER, '
      '$_countUnit TEXT, '
      '$_feeling INTEGER)';
  static const String _tableName = 'goals';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _count = 'count';
  static const String _countUnit = 'countUnit';
  static const String _feeling = 'feeling';

  Future updateCount(Goal goal) async {
    final Database db = await getDatabase();
    return db.rawUpdate(
        'UPDATE $_tableName SET $_count=${goal.count} WHERE $_id=${goal.id}');
  }

  Future remove(int goalId) async {
    final Database db = await getDatabase();
    return db.rawDelete('DELETE FROM $_tableName WHERE $_id=$goalId');
  }

  Future<int> save(Goal goal) async {
    final Database db = await getDatabase();
    Map<String, dynamic> goalMap = _toMap(goal);
    return db.insert(_tableName, goalMap);
  }

  Map<String, dynamic> _toMap(Goal goal) {
    final Map<String, dynamic> goalMap = Map();
    goalMap['$_title'] = goal.title;
    goalMap['$_count'] = goal.count;
    goalMap['$_countUnit'] = goal.countUnit;
    goalMap['$_feeling'] = goal.feeling;
    return goalMap;
  }

  Future<List<Goal>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> queryResult = await db.query(_tableName);
    List<Goal> goals = _toList(queryResult);
    return goals;
  }

  List<Goal> _toList(List<Map<String, dynamic>> queryResult) {
    final List<Goal> goals = List();
    for (Map<String, dynamic> row in queryResult) {
      final Goal goal = Goal(
        row['$_id'],
        row['$_title'],
        row['$_count'],
        row['$_countUnit'],
        row['$_feeling'],
      );
      goals.add(goal);
    }
    return goals;
  }
}
