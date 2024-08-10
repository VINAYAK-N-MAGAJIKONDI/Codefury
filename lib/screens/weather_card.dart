import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({Key? key}) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String city = "";
  Map<String, dynamic>? weatherData;
  Position? _userLocation;

  final String apiKey = 'd5067b02b5530d96e923876116fb701d'; // Replace with your API key

  Future<void> getWeatherByLocation(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
        city = weatherData!['name'];
      });
    } else {
      setState(() {
        weatherData = null;
      });
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> getWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      setState(() {
        weatherData = null;
      });
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request permission
      if (await Geolocator.isLocationServiceEnabled()) {
        // Location services are now enabled
        _determinePosition();
      } else {
        // Location services are still disabled, show an error message
        print('Location services are disabled.');
      }
      return;
    }

    // Check if location permissions are granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        // Location permissions are permanently denied, show an error message
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        // Location permissions are granted, get the current position
        _determinePosition();
      }
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _determinePosition();
    }
  }

  Future<void> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      getWeatherByLocation(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                if (weatherData != null)
            WeatherDetails(weatherData: weatherData!)
        else if (weatherData == null && city.isNotEmpty)
    Center(child: Text('No weather data available.'))
    else
    Center(child: CircularProgressIndicator()),
    ],
    ),
    ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherDetails({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Place: ${weatherData['name']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.thermostat,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Temperature: ${weatherData['main']['temp']}°C',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.brightness_low,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Description: ${weatherData['weather'][0]['description']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.water_drop,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Humidity: ${weatherData['main']['humidity']}%',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.wind_power,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Wind Speed: ${weatherData['wind']['speed']} m/s',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.wb_sunny,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000).toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.nightlight,
              color: Colors.blue.shade900,
            ),
            SizedBox(width: 8),
            Text(
              'Sunset: ${DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000).toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}