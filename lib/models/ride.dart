// Ride model represents a single ride offer
class Ride {
  final String driverName;
  final String from;
  final String to;
  final String date;
  final String time;
  final int price;
  final int seats;

  // Constructor
  Ride({
    required this.driverName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.seats,
  });

  // Check if ride details are valid
// Used to validate ride input before saving
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
      );

  // Reduce available seats when booking
// Handles seat reduction when a passenger books seats
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
    );
  }
}