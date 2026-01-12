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
        driverName: json["driverName"],
        from: json["from"],
        to: json["to"],
        date: json["date"],
        time: json["time"],
        price: json["price"],
        seats: json["seats"],
      );
}
