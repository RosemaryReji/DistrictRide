import 'package:flutter/material.dart';
import 'route_screen.dart';
import 'offer_ride_screen.dart';
import 'profile_screen.dart';
import 'my_bookings_screen.dart';
import '../services/booking_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bookingCount = 0;

  int selectedIndex = 0;

  final screens = [
    Container(), // Home (current screen)
    RouteScreen(),
    ProfileScreen(),
    Container(), // Safety (future)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF5FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Hello, Rosemary 👋",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 🔹 Find & Offer buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RouteScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Find a Ride",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OfferRideScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Offer a Ride",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 MY BOOKINGS BUTTON (NEW)
            SizedBox(
  width: double.infinity,
  child: Stack(
    children: [
      ElevatedButton.icon(
        icon: const Icon(Icons.receipt_long),
        label: const Text(
          "My Bookings",
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MyBookingsScreen(),
            ),
          );

          // Refresh count after returning
          loadBookingCount();
        },
      ),

      if (bookingCount > 0)
        Positioned(
          right: 16,
          top: 6,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: Text(
              bookingCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    ],
  ),
),


            const SizedBox(height: 30),

            /// 🔹 Activity section
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Your ride activity will appear here",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "DistrictRide v1.0 • Built by Rosemary",
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: "Rides"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shield), label: "Safety"),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
  @override
void initState() {
  super.initState();
  loadBookingCount();
}

Future<void> loadBookingCount() async {
  final bookings = await BookingService.getBookings();
  setState(() {
    bookingCount = bookings.length;
  });
}

}
