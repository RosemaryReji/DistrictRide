class Booking {
  final String driverName;
  final String from;
  final String to;
  final String date;
  final String time;
  final int seats;
  final int price;

  Booking({
    required this.driverName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.seats,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "from": from,
        "to": to,
        "date": date,
        "time": time,
        "seats": seats,
        "price": price,
      };

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        driverName: json["driverName"],
        from: json["from"],
        to: json["to"],
        date: json["date"],
        time: json["time"],
        seats: json["seats"],
        price: json["price"],
      );
}
