import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DisasterGuidesScreen extends StatefulWidget {
  const DisasterGuidesScreen({Key? key}) : super(key: key);

  @override
  State<DisasterGuidesScreen> createState() => _DisasterGuidesScreenState();
}

class _DisasterGuidesScreenState extends State<DisasterGuidesScreen> {
  List<Map<String, dynamic>> _guides = [];
  Database? _db;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'disaster_guides.db');

    _db = await openDatabase(path, version: 1, onCreate: (db, version) {
      // Create the guides table
      db.execute(
          'CREATE TABLE guides (id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
    });

    // Populate the database with initial guides (you can replace this with
    // your own guide data)
    await _db!.transaction((txn) async {
      await txn.insert('guides', {'title': 'Earthquake Preparedness', 'content': 'Earthquake guide content...'});
      await txn.insert('guides', {'title': 'Hurricane Preparedness', 'content': 'Hurricane guide content...'});
      await txn.insert('guides', {'title': 'Flood Preparedness', 'content': 'Flood guide content...'});
    });

    _loadGuides();
  }

  Future<void> _loadGuides() async {
    final data = await _db!.query('guides');
    setState(() {
      _guides = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100, // Set background color
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Set app bar color
        title: const Text(
          'Disaster Guides',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: ListView.builder(
        itemCount: _guides.length,
        itemBuilder: (context, index) {
          final guide = _guides[index];
          return ListTile(
            title: Text(
              guide['title'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to a detailed guide screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuideDetailScreen(
                    title: guide['title'],
                    content: guide['content'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GuideDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const GuideDetailScreen({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100, // Set background color
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Set app bar color
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}