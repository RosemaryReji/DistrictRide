class Ride {
  final String driverName;
  final String from;
  final String to;
  final String date;
  final String time;
  final int price;
  final int seats;

  Ride({
    required this.driverName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.seats,
  });

  bool get isValid {
    return from.isNotEmpty &&
        to.isNotEmpty &&
        price > 0 &&
        seats > 0;
  }

  Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "from": from,
        "to": to,
        "date": date,
        "time": time,
        "price": price,
        "seats": seats,
      };

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        driverName: json["driverName"] ?? "",
        from: json["from"] ?? "",
        to: json["to"] ?? "",
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        price: json["price"] ?? 0,
        seats: json["seats"] ?? 0,
      );
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