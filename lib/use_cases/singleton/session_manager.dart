import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
 
class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
 
  static const String _boxName = "sessionBox";
  Box? _box;
 
  factory SessionManager() {
    return _instance;
  }

  static SessionManager getInstance() {
    return _instance;
  }
 
  SessionManager._internal();
 
  Future<void> init() async {
    if(!Hive.isBoxOpen(_boxName)) {
      await Hive.initFlutter();
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }
  }

  Future<void> setToken(String token ) async {
    await _box!.put("token", token);
  }
  String? getToken() {
    return _box!.get("token");
  }
}