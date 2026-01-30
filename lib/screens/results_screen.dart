
import '../models/ride.dart';
import '../models/booking.dart';
import '../services/ride_service.dart';
import '../services/booking_service.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final Ride ride;

  const BookingConfirmationScreen({
    super.key,
    required this.ride,
  });

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState
    extends State<BookingConfirmationScreen> {
  bool isProcessing = true;

  @override
  void initState() {
    super.initState();
    confirmBooking();
  }

  Future<void> confirmBooking() async {
    try {
      // 1️⃣ Reduce seat count
      final updatedRide = widget.ride.bookSeats(1);

      // 2️⃣ Update ride in storage
      await RideService.updateRide(updatedRide);

      // 3️⃣ Save booking
      final booking = Booking(
        driverName: widget.ride.driverName,
        from: widget.ride.from,
        to: widget.ride.to,
        date: widget.ride.date,
        time: widget.ride.time,
        seats: 1,
        price: widget.ride.price,
      );

      await BookingService.addBooking(booking);

      setState(() {
        isProcessing = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking failed: $e")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Status")),
      body: Center(
        child: isProcessing
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle,
                      size: 80, color: Colors.green),
                  const SizedBox(height: 20),
                  Text(
                    "Your ride with ${widget.ride.driverName} is confirmed!",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Seats booked: 1",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Total price: ₹${widget.ride.price}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context, (route) => route.isFirst);
                    },
                    child: const Text("Go to Home"),
                  )
                ],
              ),
      ),
    );
  }
}

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
