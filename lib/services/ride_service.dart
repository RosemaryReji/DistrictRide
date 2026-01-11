import '../models/ride.dart';

class RideService {
  static List<Ride> getAvailableRides() {
    return [
      Ride(
        driverName: "Anu",
        from: "Ernakulam",
        to: "Thrissur",
        date: "12/1/2026",
        time: "10:00 AM",
        price: 120,
        seats: 2,
      ),
      Ride(
        driverName: "Rahul",
        from: "Ernakulam",
        to: "Thrissur",
        date: "12/1/2026",
        time: "11:30 AM",
        price: 150,
        seats: 1,
      ),
      Ride(
        driverName: "Meera",
        from: "Ernakulam",
        to: "Thrissur",
        date: "12/1/2026",
        time: "02:00 PM",
        price: 100,
        seats: 3,
      ),
    ];
  }
}
