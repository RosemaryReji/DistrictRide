import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ride.dart';

class RideService {
  static const String _key = "rides";

  // Get all available rides
  static Future<List<Ride>> getAvailableRides() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List list = jsonDecode(data);
    return list.map((e) => Ride.fromJson(e)).toList();
  }

  // Add a new ride
  static Future<void> addRide(Ride ride) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await getAvailableRides();

    existing.add(ride);

    final encoded =
        jsonEncode(existing.map((e) => e.toJson()).toList());

    await prefs.setString(_key, encoded);
  }

  // Update an existing ride (after booking seats)
  static Future<void> updateRide(Ride updatedRide) async {
    final prefs = await SharedPreferences.getInstance();
    final rides = await getAvailableRides();

    final index = rides.indexWhere((r) =>
        r.driverName == updatedRide.driverName &&
        r.from == updatedRide.from &&
        r.to == updatedRide.to &&
        r.date == updatedRide.date &&
        r.time == updatedRide.time);

    if (index != -1) {
      rides[index] = updatedRide;
      final encoded =
          jsonEncode(rides.map((e) => e.toJson()).toList());
      await prefs.setString(_key, encoded);
    }
  }

  // Find matching rides
  static Future<List<Ride>> findMatchingRides({
    required String from,
    required String to,
    required String date,
  }) async {
    final rides = await getAvailableRides();

    return rides.where((ride) {
      return ride.from.toLowerCase() == from.toLowerCase() &&
          ride.to.toLowerCase() == to.toLowerCase() &&
          ride.date == date;
    }).toList();
  }

  // Check if rides exist
  static Future<bool> hasRides() async {
    final rides = await getAvailableRides();
    return rides.isNotEmpty;
  }
}
