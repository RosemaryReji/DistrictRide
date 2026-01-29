class Booking {
  final String rideId;
  final String passengerName;
  final int seatsBooked;
  final String status; // pending, confirmed, cancelled

  Booking({
    required this.rideId,
    required this.passengerName,
    required this.seatsBooked,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        "rideId": rideId,
        "passengerName": passengerName,
        "seatsBooked": seatsBooked,
        "status": status,
      };

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        rideId: json["rideId"] ?? "",
        passengerName: json["passengerName"] ?? "",
        seatsBooked: json["seatsBooked"] ?? 0,
        status: json["status"] ?? "pending",
      );
}