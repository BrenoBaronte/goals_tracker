import 'package:build/database/dao/goal_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'build.db');

  return await openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(GoalDao.tableSql);
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );
}
