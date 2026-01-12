import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  double rating = 4.8;

  User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await UserService.getUser();
    if (user != null) {
      nameController.text = user!.name;
      phoneController.text = user!.phone;
      rating = user!.rating;
      setState(() {});
    }
  }

  void save() async {
    final newUser = User(
      name: nameController.text,
      phone: phoneController.text,
      rating: rating,
    );

    await UserService.saveUser(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved")),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFEBF5FF),
    appBar: AppBar(
      title: const Text("My Profile"),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),

          const SizedBox(height: 12),

          Text(
            nameController.text.isEmpty ? "Your Name" : nameController.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber),
              Text(rating.toString()),
            ],
          ),

          const SizedBox(height: 30),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: "Phone",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: save,
              child: const Text("Save Profile"),
            ),
          ),
        ],
      ),
    ),
  );
}

}
