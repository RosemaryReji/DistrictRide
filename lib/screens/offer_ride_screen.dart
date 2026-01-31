import 'package:flutter/material.dart';
import '../models/ride.dart';
import '../services/ride_service.dart';
import '../data/districts.dart';
import '../services/user_service.dart';

class OfferRideScreen extends StatefulWidget {
  const OfferRideScreen({super.key});

  @override
  State<OfferRideScreen> createState() => _OfferRideScreenState();
}

class _OfferRideScreenState extends State<OfferRideScreen> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final priceController = TextEditingController();
  final seatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offer a Ride")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
  items: keralaDistricts.map((d) {
    return DropdownMenuItem(value: d, child: Text(d));
  }).toList(),
  onChanged: (value) {
    fromController.text = value!;
  },
  decoration: const InputDecoration(
    labelText: "From",
    border: OutlineInputBorder(),
  ),
),

            DropdownButtonFormField<String>(
  items: keralaDistricts.map((d) {
    return DropdownMenuItem(value: d, child: Text(d));
  }).toList(),
  onChanged: (value) {
    toController.text = value!;
  },
  decoration: const InputDecoration(
    labelText: "To",
    border: OutlineInputBorder(),
  ),
),

            TextField(
  controller: dateController,
  readOnly: true,
  decoration: const InputDecoration(
    labelText: "Date",
    border: OutlineInputBorder(),
  ),
  onTap: () async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      dateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  },
),

const SizedBox(height: 10),

TextField(
  controller: timeController,
  readOnly: true,
  decoration: const InputDecoration(
    labelText: "Time",
    border: OutlineInputBorder(),
  ),
  onTap: () async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text = picked.format(context);
    }
  },
),

            buildField("Price", priceController),
            buildField("Seats", seatsController),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: postRide,
              child: const Text("Post Ride"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> postRide() async {

    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        priceController.text.isEmpty ||
        seatsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final user = await UserService.getUser();

final newRide = Ride(
  driverName: user?.name ?? "You",
  from: fromController.text,
  to: toController.text,
  date: dateController.text,
  time: timeController.text,
  price: int.parse(priceController.text),
  seats: int.parse(seatsController.text),
  rating: 4.5, // ⭐ default rating
);


    RideService.addRide(newRide);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ride posted successfully")),
    );

    Navigator.pop(context);
  }
}
