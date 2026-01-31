import 'package:flutter/material.dart';
import '../models/ride.dart';
import '../services/ride_service.dart';
import 'booking_confirmation_screen.dart';



class ResultsScreen extends StatefulWidget {
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
  State<ResultsScreen> createState() => _ResultsScreenState();
}


 class _ResultsScreenState extends State<ResultsScreen> {
  String sortBy = "price";



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Rides")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: ${widget.from}", style: const TextStyle(fontSize: 16)),
Text("To: ${widget.to}", style: const TextStyle(fontSize: 16)),
Text("Date: ${widget.date}", style: const TextStyle(fontSize: 16)),
Text("Time: ${widget.time}", style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            const Divider(),

            const Text(
              "Matching rides",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
            Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    const Text("Sort by: "),
    DropdownButton<String>(
      value: sortBy,
      items: const [
        DropdownMenuItem(
          value: "price",
          child: Text("Price"),
        ),
        DropdownMenuItem(
          value: "seats",
          child: Text("Seats"),
        ),
      ],
      onChanged: (value) {
        setState(() {
          sortBy = value!;
        });
      },
    ),
  ],
),
const SizedBox(height: 10),


            Expanded(
              child: FutureBuilder<List<Ride>>(
                future: RideService.findMatchingRides(
  from: widget.from,
  to: widget.to,
  date: widget.date,
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

if (sortBy == "price") {
  rides.sort((a, b) => a.price.compareTo(b.price));
} else {
  rides.sort((a, b) => b.seats.compareTo(a.seats));
}


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
