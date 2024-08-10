import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DisasterManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: DisasterFeedPage(),
    );

  }
}

class DisasterFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SectionWidget(
          title: "Understanding Natural Disasters",
          content: "Learn about different types of natural disasters and their causes...",
          videoUrl: "https://youtu.be/-FBq5lE1Kz0?si=5u-KuGVBnnLcWRb7",
          backgroundColor: Colors.white70, // Section background color
        ),
        SectionWidget(
          title: "Emergency Preparedness",
          content: "Find out how to prepare for emergencies and disasters...",
          videoUrl: "https://youtu.be/FVwvbS-0q18?si=E6Uk-Mm7CmYlH5HG",
          backgroundColor: Colors.white70, // Section background color
        ),
        SectionWidget(
          title: "Disaster Response Strategies",
          content: "Explore strategies for responding to disasters...",
          videoUrl: "https://youtu.be/cWYcXhMhJF4?si=Mr7bgvt4DxEO3GcA",
          backgroundColor: Colors.white70, // Section background color
        ),
        SectionWidget(
          title: "Community Resilience",
          content: "Learn how communities can build resilience to disasters...",
          videoUrl: "https://youtu.be/Fwb8VRyqAU4?si=juXRf1bNIYJSIzAa",
          backgroundColor: Colors.white70, // Section background color
        ),
        SectionWidget(
          title: "Climate Change and Disasters",
          content: "Understand the impact of climate change on natural disasters...",
          videoUrl: "https://youtu.be/PPkjYf4rd_E?si=srHPxUBg4imGK2wM",
          backgroundColor: Colors.white70, // Section background color
        ),
        // Add more SectionWidget for additional sections
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String content;
  final String? videoUrl; // Nullable string
  final Color backgroundColor;

  SectionWidget({
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    String? videoId = videoUrl != null ? YoutubePlayer.convertUrlToId(videoUrl!) : null;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.redAccent), // Disaster-related icon
              SizedBox(width: 10.0),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87), // Change text color
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(color: Colors.black87), // Change text color
          ),
          SizedBox(height: 12.0),
          if (videoId != null)
            InkWell(
              onTap: () {
                _launchYoutubeVideo(videoUrl!);
              },
              child: Container(
                height: 200,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Function to launch YouTube video
  void _launchYoutubeVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}