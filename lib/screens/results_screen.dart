import 'package:flutter/material.dart';
import '../models/ride.dart';
import '../services/ride_service.dart';
import 'booking_confirmation_screen.dart';

class ResultsScreen extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String time;

  const ResultsScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Rides")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: $from", style: const TextStyle(fontSize: 16)),
            Text("To: $to", style: const TextStyle(fontSize: 16)),
            Text("Date: $date", style: const TextStyle(fontSize: 16)),
            Text("Time: $time", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            const Divider(),

            const Text(
              "Matching rides",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: FutureBuilder<List<Ride>>(
                future: RideService.findMatchingRides(
                  from: from,
                  to: to,
                  date: date,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No rides found"),
                    );
                  }

                  final matchingRides = snapshot.data!;

                  return ListView.builder(
                    itemCount: matchingRides.length,
                    itemBuilder: (context, index) {
                      final ride = matchingRides[index];

                      return RideTile(
                        name: ride.driverName,
                        seats: "${ride.seats} seats",
                        price: "₹${ride.price}",
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideTile extends StatelessWidget {
  final String name;
  final String seats;
  final String price;

  const RideTile({
    super.key,
    required this.name,
    required this.seats,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingConfirmationScreen(
                driverName: name,
                seats: seats,
                price: price,
              ),
            ),
          );
        },
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(name),
          subtitle: Text(seats),
          trailing: Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
