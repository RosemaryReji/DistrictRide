import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DistrictRideApp());
}

class DistrictRideApp extends StatelessWidget {
  const DistrictRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
