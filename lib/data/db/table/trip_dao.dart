import 'package:itrip/data/model/trip.dart';
import 'package:sqflite/sqflite.dart';

class TripDao {
  static const String tableName = 'trip';

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        companied TEXT,
        photoPath TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  static Future<int> insert(Database db, Trip trip) async {
    return await db.insert(tableName, trip.toJson());
  }

  static Future<List<Trip>> getAll(Database db) async {
    final List<Map<String, dynamic>> resultSet = await db.query(tableName);
    return resultSet.map((mt) => Trip.fromJson(mt)).toList();
  }

  static Future<Trip?> getById(Database db, int id) async {
    final List<Map<String, dynamic>> resultSet = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultSet.isNotEmpty) {
      return Trip.fromJson(resultSet.first);
    }
    return null;
  }

  static Future<int> update(Database db, Trip trip) async {
    return await db.update(
      tableName,
      trip.toJson(),
      where: 'id = ?',
      whereArgs: [trip.id],
    );
  }

  static Future<int> delete(Database db, int id) async {
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
