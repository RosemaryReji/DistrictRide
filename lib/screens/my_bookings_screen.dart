import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/ride.dart';
import '../services/booking_service.dart';
import '../services/ride_service.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: FutureBuilder<List<Booking>>(
        future: BookingService.getBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings yet"));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const Icon(Icons.event_seat),
                  title: Text("${booking.from} → ${booking.to}"),
                  subtitle: Text(
                    "${booking.date} at ${booking.time}\nDriver: ${booking.driverName}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Cancel booking?"),
                          content: const Text(
                            "Are you sure you want to cancel this booking?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text("Yes, Cancel"),
                            ),
                          ],
                        ),
                      );

                      if (confirm != true) return;

                      // 1️⃣ Remove booking
                      await BookingService.removeBooking(booking);

                      // 2️⃣ Restore seat to ride
                      final ride = Ride(
                        driverName: booking.driverName,
                        from: booking.from,
                        to: booking.to,
                        date: booking.date,
                        time: booking.time,
                        price: booking.price,
                        seats: 0,
                        rating: 4.5, // default or stored rating
                      );

                      await RideService.restoreSeat(
                        ride,
                        booking.seats,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Booking cancelled"),
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyBookingsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
