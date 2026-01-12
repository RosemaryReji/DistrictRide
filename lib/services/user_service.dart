import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const String _key = "user";

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return null;

    return User.fromJson(jsonDecode(data));
  }
}
