import 'package:build/models/goal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'build.db');

  return await openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE goals('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'count INTEGER, '
          'countUnit TEXT, '
          'feeling INTEGER)');
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Goal goal) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> goalMap = Map();
  goalMap['title'] = goal.title;
  goalMap['count'] = goal.count;
  goalMap['countUnit'] = goal.countUnit;
  goalMap['feeling'] = goal.feeling;
  return db.insert('goals', goalMap);
}

Future<List<Goal>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> queryResult = await db.query('goals');
  final List<Goal> goals = List();
  for (Map<String, dynamic> row in queryResult) {
    final Goal goal = Goal(
      row['id'],
      row['title'],
      row['count'],
      row['countUnit'],
      row['feeling'],
    );
    goals.add(goal);
  }
  return goals;
}
