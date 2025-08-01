import 'package:itrip/data/db/table/trip_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;
  static Future<Database> getDb() async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'itrip.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await TripDao.createTable(db);
    });
    return _db!;
  }

  static Future<void> closeDb() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }

  static Future<void> clearAllData() async {
    final db = await getDb();
    await db.delete(TripDao.tableName);
  }
}
