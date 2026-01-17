import 'dart:convert';
import '../models/ride.dart';
import '../main.dart';

class RideService {
  static const String _key = "rides";

  static Future<List<Ride>> getAvailableRides() async {
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List list = jsonDecode(data);
    return list.map((e) => Ride.fromJson(e)).toList();
  }

  static Future<void> addRide(Ride ride) async {
    final existing = await getAvailableRides();
    existing.add(ride);

    final encoded = jsonEncode(existing.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
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
static Future<bool> hasRides() async {
  final rides = await getAvailableRides();
  return rides.isNotEmpty;
}
