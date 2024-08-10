import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'weather_card.dart';
import 'news_carasoul.dart';
import 'disaster_guides_screen.dart';
import 'earthquake_alert_screen.dart';
import 'custom_appbar.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login
    } catch (e) {
      print('Error signing out: $e');
      // You might want to display an error message to the user here
    }
  }



  final PageController _pageController = PageController();


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Set the preferred size
        child: const CustomAppBar(), // Wrap CustomAppBar with PreferredSize
      ), // Use your CustomAppBar widget
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // Home Page
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Buddy!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                WeatherCard(),
                SizedBox(height: 20),
                NewsCarousel(),

              ],
            ),
          ),

          // Search Page
          // (You will need to create a SearchPage widget or reuse an existing one)
             DisasterManagementApp(),

          // Disaster Guides Page
          const DisasterGuidesScreen(), // Assuming EarthquakeAlertScreen displays your disaster guides
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.backup_table_rounded),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book), // Changed the icon
            label: 'Guides', // Changed the label
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey.shade500,
        onTap: _onItemTapped, // Call _onItemTapped when an item is tapped
      ),
    );
  }
}