class Payment {
  final String bookingId;
  final int amount;
  final String method; // UPI, Cash, Wallet
  final String status; // pending, paid, failed

  Payment({
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "amount": amount,
        "method": method,
        "status": status,
      };

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        bookingId: json["bookingId"] ?? "",
        amount: json["amount"] ?? 0,
        method: json["method"] ?? "UPI",
        status: json["status"] ?? "pending",
      );
}