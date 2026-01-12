import 'package:flutter/material.dart';
import 'results_screen.dart';
import '../data/districts.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {



  
  final fromController = TextEditingController();
final toController = TextEditingController();
final dateController = TextEditingController();
final timeController = TextEditingController();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Route")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("From", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
  value: null,
  items: keralaDistricts.map((district) {
    return DropdownMenuItem(
      value: district,
      child: Text(district),
    );
  }).toList(),
  onChanged: (value) {
    fromController.text = value!;
  },
  decoration: const InputDecoration(
    labelText: "From",
    border: OutlineInputBorder(),
  ),
),

            const SizedBox(height: 20),
            const Text("To", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
           DropdownButtonFormField<String>(
  value: null,
  items: keralaDistricts.map((district) {
    return DropdownMenuItem(
      value: district,
      child: Text(district),
    );
  }).toList(),
  onChanged: (value) {
    toController.text = value!;
  },
  decoration: const InputDecoration(
    labelText: "To",
    border: OutlineInputBorder(),
  ),
),



            const SizedBox(height: 20),
            const Text("Date"),
            const SizedBox(height: 8),
            TextField(
  controller: dateController,
  readOnly: true,
  decoration: InputDecoration(
    labelText: "Select Date",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    prefixIcon: Icon(Icons.calendar_today),
  ),
  onTap: () async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  },
),


            const SizedBox(height: 20),
            const Text("Time"),
            const SizedBox(height: 8),
            TextField(
  controller: timeController,
  readOnly: true,
  decoration: InputDecoration(
    labelText: "Select Time",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    prefixIcon: Icon(Icons.access_time),
  ),
  onTap: () async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      timeController.text = pickedTime.format(context);
    }
  },
),


            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
  if (fromController.text.isEmpty ||
      toController.text.isEmpty ||
      dateController.text.isEmpty ||
      timeController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultsScreen(
        from: fromController.text,
        to: toController.text,
        date: dateController.text,
        time: timeController.text,
      ),
    ),
  );
},

                child: const Text("Search Rides"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
