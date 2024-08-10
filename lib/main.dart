import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/login_screen.dart';
import 'package:phone_auth/screens/home_screen.dart';
import 'package:phone_auth/screens/disaster_guides_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import new screen
// Import new screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // Request notification permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  // Handle permissions
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    // Get the device token and store it securely
    String? token = await messaging.getToken();
    if (token != null) {
      print('Token: $token');
      // Store the token in Firestore (or your preferred method)
      await FirebaseFirestore.instance.collection('deviceTokens').doc().set({
        'token': token,
      });
    }
  } else if (settings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // Handle received notifications (foreground)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification}');
    }
  });

  // Handle received notifications (background)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the background!');
    print('Message data: ${message.data}');

    // You can navigate to a relevant screen based on the message data
  });

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

        '/disasterGuides': (context) => const DisasterGuidesScreen(), // Add route

      },
    );
  }
}

// ... Your other screens (HomeScreen, LoginScreen, EarthquakeAlertScreen, etc.)