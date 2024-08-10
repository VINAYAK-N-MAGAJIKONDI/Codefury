import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/login_screen.dart';
import 'package:phone_auth/screens/home_screen.dart';
import 'package:phone_auth/screens/earthquake_alert_screen.dart'; // Import new screen
import 'package:phone_auth/screens/disaster_guides_screen.dart'; // Import new screen
// Import new screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        //'/earthquakeAlerts': (context) => const EarthquakeAlertScreen(), // Add route
        '/disasterGuides': (context) => const DisasterGuidesScreen(), // Add route
 // Add route
      },
    );
  }
}