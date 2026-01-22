/// RideService handles all ride-related data operations
/// - Saving rides
/// - Fetching rides
/// - Filtering matching rides
/// - Checking availability

import 'dart:convert';
import '../models/ride.dart';
import '../main.dart';

class RideService {
  static const String _key = "rides";

  // Get all available rides from local storage
  static Future<List<Ride>> getAvailableRides() async {
    final data = prefs.getString(_key);

    // If no rides are stored, return empty list
    if (data == null) return [];

    final List list = jsonDecode(data);

    // Convert JSON list to Ride objects
    return list.map((e) => Ride.fromJson(e)).toList();
  }

  // Add a new ride and save it
  static Future<void> addRide(Ride ride) async {
    final existing = await getAvailableRides();

    existing.add(ride);

    final encoded =
        jsonEncode(existing.map((e) => e.toJson()).toList());

    await prefs.setString(_key, encoded);
  }

  // Find rides that match from, to, and date
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

  // Check if any rides exist
  static Future<bool> hasRides() async {
    final rides = await getAvailableRides();
    return rides.isNotEmpty;
  }
}