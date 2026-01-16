import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rating.dart';

class RatingService {
  static const String _key = "ratings";

  static Future<List<Rating>> getRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List list = jsonDecode(data);
    return list.map((e) => Rating.fromJson(e)).toList();
  }

  static Future<void> addRating(Rating rating) async {
    final prefs = await SharedPreferences.getInstance();
    final ratings = await getRatings();

    ratings.add(rating);

    final encoded =
        jsonEncode(ratings.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}