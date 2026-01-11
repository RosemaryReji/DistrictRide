import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String driverName;
  final String seats;
  final String price;

  const BookingConfirmationScreen({
    super.key,
    required this.driverName,
    required this.seats,
    required this.price,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Booked")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text(
  "Your ride with $driverName is confirmed!",
  style: const TextStyle(fontSize: 18),
  textAlign: TextAlign.center,
),
const SizedBox(height: 10),

Text(
  "Seats booked: $seats",
  style: const TextStyle(fontSize: 16),
),

Text(
  "Total price: $price",
  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),

const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Go to Home"),
            )
          ],
        ),
      ),
    );
  }
}
