import 'package:hive_flutter/hive_flutter.dart';

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
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.initFlutter();
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }
  }

  Future<void> setToken(String token) async {
    await _box?.put('token', token);
  }

  String? getToken() {
    return _box?.get("token");
  }

  Future<void> setName(String name) async {
    await _box?.put('name', name);
  }

  String? getName() {
    return _box?.get("name");
  }

  Future<void> setPhotoUrl(String photoUrl) async {
    await _box?.put('photoUrl', photoUrl);
  }

  String? getPhotoUrl() {
    return _box?.get("photoUrl");
  }

  Future<void> setEmail(String email) async {
    await _box?.put('email', email);
  }

  String? getEmail() {
    return _box?.get("email");
  }

  Future<void> setRole(String role) async {
    await _box?.put('role', role);
  }

  String? getRole() {
    return _box?.get("role");
  }
}
