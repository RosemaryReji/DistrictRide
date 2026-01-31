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
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("No rides found"));
                  }

                  final rides = snapshot.data!;

                  return ListView.builder(
                    itemCount: rides.length,
                    itemBuilder: (context, index) {
                      final ride = rides[index];

                      return Card(
                        margin:
                            const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                              child: Icon(Icons.person)),
                          title: Text(ride.driverName),
                          subtitle:
                              Text("${ride.seats} seats available"),
                          trailing: ride.seats > 0
    ? ElevatedButton(
        child: const Text("Book"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingConfirmationScreen(
                ride: ride,
              ),
            ),
          );
        },
      )
    : const Chip(
        label: Text(
          "FULL",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),

                        ),
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
