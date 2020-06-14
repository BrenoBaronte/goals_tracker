import 'package:build/models/goal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'build.db');

    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE goals('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'count INTEGER, '
          'countUnit TEXT, '
          'feeling INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Goal goal) {
  return createDatabase().then((db) {
    final Map<String, dynamic> goalMap = Map();
    goalMap['title'] = goal.title;
    goalMap['count'] = goal.count;
    goalMap['countUnit'] = goal.countUnit;
    goalMap['feeling'] = goal.feeling;
    return db.insert('goals', goalMap);
  });
}

Future<List<Goal>> findAll() {
  return createDatabase().then((db) {
    return db.query('goals').then((maps) {
      final List<Goal> goals = List();
      for (Map<String, dynamic> map in maps) {
        final Goal goal = Goal(
          map['id'],
          map['title'],
          map['count'],
          map['countUnit'],
          map['feeling'],
        );
        goals.add(goal);
      }
      return goals;
    });
  });
}
