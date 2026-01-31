import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingService {
  static const String _key = "bookings";

  static Future<List<Booking>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List list = jsonDecode(data);
    return list.map((e) => Booking.fromJson(e)).toList();
  }

  static Future<void> addBooking(Booking booking) async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = await getBookings();

    bookings.add(booking);

    final encoded =
        jsonEncode(bookings.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
  static Future<void> removeBooking(Booking booking) async {
  final prefs = await SharedPreferences.getInstance();
  final bookings = await getBookings();

  bookings.removeWhere((b) =>
      b.driverName == booking.driverName &&
      b.from == booking.from &&
      b.to == booking.to &&
      b.date == booking.date &&
      b.time == booking.time);

  final encoded =
      jsonEncode(bookings.map((e) => e.toJson()).toList());
  await prefs.setString(_key, encoded);
}

}