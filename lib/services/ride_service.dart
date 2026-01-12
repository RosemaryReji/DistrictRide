import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ride.dart';

class RideService {
  static const String _key = "rides";

  static Future<List<Ride>> getAvailableRides() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List list = jsonDecode(data);
    return list.map((e) => Ride.fromJson(e)).toList();
  }

  static Future<void> addRide(Ride ride) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await getAvailableRides();

    existing.add(ride);

    final encoded = jsonEncode(existing.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
