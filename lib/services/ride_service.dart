import '../models/ride.dart';

class RideService {
  static final List<Ride> _rides = [
    Ride(
      driverName: "Arjun",
      from: "Kottayam",
      to: "Kochi",
      date: "12/1/2026",
      time: "9:00 AM",
      price: 120,
      seats: 3,
    ),
    Ride(
      driverName: "Neha",
      from: "Kottayam",
      to: "Kochi",
      date: "12/1/2026",
      time: "10:30 AM",
      price: 100,
      seats: 2,
    ),
  ];

  static List<Ride> getAvailableRides() {
    return _rides;
  }

  static void addRide(Ride ride) {
    _rides.add(ride);
  }
}
