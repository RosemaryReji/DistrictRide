// Ride model represents a single ride offer
class Ride {
  final String driverName;
  final String from;
  final String to;
  final String date;
  final String time;
  final int price;
  final int seats;
  final double rating;

  // Constructor
  Ride({
    required this.driverName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.seats,
    required this.rating,
  });

  // Check if ride details are valid
  bool get isValid {
    return from.isNotEmpty &&
        to.isNotEmpty &&
        price > 0 &&
        seats > 0;
  }

  // Convert Ride object to JSON for storage
  Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "from": from,
        "to": to,
        "date": date,
        "time": time,
        "price": price,
        "seats": seats,
        "rating": rating,
      };

  // Create Ride object from JSON
  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        driverName: json["driverName"] ?? "",
        from: json["from"] ?? "",
        to: json["to"] ?? "",
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        price: json["price"] ?? 0,
        seats: json["seats"] ?? 0,
        rating: (json["rating"] ?? 4.5).toDouble(),
      );

  // Reduce available seats when booking
  Ride bookSeats(int count) {
    if (count > seats) {
      throw Exception("Not enough seats available");
    }

    return Ride(
      driverName: driverName,
      from: from,
      to: to,
      date: date,
      time: time,
      price: price,
      seats: seats - count,
      rating: rating, // ⭐ IMPORTANT
    );
  }
}
